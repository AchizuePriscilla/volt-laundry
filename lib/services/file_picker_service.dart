import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:volt/utils/logger.dart';

abstract class FileDownloadService {
  Future<String> downloadFile({
    required String url,
    required String savePath,
    Function(int, int)? onReceiveProgress,
  });
}

class FileDownloadServiceImpl implements FileDownloadService {
  late Dio dio;

  FileDownloadServiceImpl() {
    dio = Dio();
  }

  @override
  Future<String> downloadFile({
    required String url,
    required String savePath,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final response = await dio.get(
        url,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return (status ?? 0) < 500;
          },
        ),
      );
      final filePath = tempDir.path + savePath;

      final file = File(filePath);
      var raf = file.openSync(mode: FileMode.write);

      raf.writeFromSync(response.data);
      await raf.close();

      return filePath;
    } catch (e) {
      AppLogger.logger.d(e);
      return '';
    }
  }
}
