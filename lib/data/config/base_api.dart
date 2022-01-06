import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:volt/data/local/local_cache.dart';
import 'package:volt/data/remote/connectivity_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/utils/utils.dart';

abstract class BaseApi {
  late Dio dio;

  BaseApi(String baseApi) {
    final options = BaseOptions(
        baseUrl: "https://$baseApi",
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000, // 60 seconds
        headers: {
          'API-KEY': 'b1103269-dca6-459b-9867-c9dfeba3e196',
          'X-ACCESS-TOKEN':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZDM1ZGQ4MGM0NjAwZmYxOWE2ZDFmMSIsIm5hbWUiOiJGb28gQmFyIiwiZW1haWwiOiJmb29AbWFpbC5jb20iLCJwaG9uZSI6IisxMjM0NTY3OCIsInBhc3N3b3JkIjoiY2FhODJkZWEyNDlmNjQwY2RjZTY4NWUzMjk3NmQ5NzE0NzBiZDdjMGQ5OTE4ZjJmNTM3YWIzNmVjMmQzMjc0MyIsImNyZWF0ZWRBdCI6IjIwMjItMDEtMDNUMjA6MzQ6MzEuNDMxWiIsInVwZGF0ZWRBdCI6IjIwMjItMDEtMDNUMjA6MzQ6MzEuNDMxWiIsImxvY2F0aW9uIjp7ImFkZHJlc3MiOiJVTk4iLCJjb3VudHJ5IjoiTkciLCJzdGF0ZSI6IkVudWd1IiwibGF0IjoyMywibG5nIjoyM30sIndhbGxldCI6eyJWTFRfQ09JTiI6eyJjdXJyZW5jeSI6IlZMVENPSU4iLCJhbW91bnQiOjB9LCJWTFRfTkdOIjp7ImN1cnJlbmN5IjoiVk5HTiIsImFtb3VudCI6MH19LCJpYXQiOjE2NDEyNDIwNzIsImV4cCI6MTY0MTg0Njg3Mn0.BspCY1MRgQ-GEVuUpX1X4fAt5LS62TcNuoCXuUCVcNw'
        });

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (
      options,
      handler,
    ) async {
      //no internet? reject request
      if (!await locator<ConnectivityService>().hasInternet()) {
        handler.reject(
          DioError(
            requestOptions: options,
            error:
                "Oops! Looks like you're not connected to the internet. Check your internet connection and try again.",
          ),
        );
      }

      var token = await locator<LocalCache>().getToken();
      AppLogger.logger.d(token);
      if (token != null) {
        options.headers['authorization'] = 'Bearer $token';
      }
      handler.next(options);
    }));
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  Future<Either<Failure, Success>> get(
    path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) =>
      makeRequest(
        dio.request(
          "/$path",
          data: data,
          options: Options(
            method: "GET",
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Either<Failure, Success>> post(path,
      {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) {
    return makeRequest(dio.post(
      "/$path",
      data: data,
      options: Options(
        headers: {
          ...headers, // set content-length
        },
      ),
    ));
  }

  Future<Either<Failure, Success>> patch(path,
      {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) {
    return makeRequest(dio.patch(
      "/$path",
      data: data,
      options: Options(
        headers: {
          ...headers, // set content-length
        },
      ),
    ));
  }

  Future<Either<Failure, Success>> put(path,
          {Map<String, dynamic>? data,
          Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.put(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Either<Failure, Success>> delete(path,
          {Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.delete(
          "/$path",
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Either<Failure, Success>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;

      var data = req.data;

      AppLogger.logger.d(
          'this is the status code for every request made=> ${req.statusCode}');

      //check for status code that indicates expired session and log user out
      log('Status Code: ${req.statusCode.toString()}');
      if ("${req.statusCode}".startsWith('2')) {
        return Right(Success(data));
      }

      return Left(Failure(data["message"]));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Left(
          Failure(
            const ApiErrorResponse(
              message:
                  "Oops. It took too long to send your request. Check your internet connection and try again.",
            ),
          ),
        );
      }
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null && e.response!.data is Map) {
          return Left(Failure.fromMap(e.response!.data));
        }
        return Left(Failure(e.response?.data));
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Left(Failure(
          ApiErrorResponse(message: e.message),
        ));
      }
    }
  }

  dynamic parseErrorMessage(Map<String, dynamic>? err) {
    if (err != null) {}
    return "Unknown error";
  }
}
