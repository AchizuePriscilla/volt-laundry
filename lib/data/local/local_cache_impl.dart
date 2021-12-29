import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/data/local/local_cache.dart';
import 'package:volt/data/local/secure_storage.dart';
import 'package:volt/utils/logger.dart';

class LocalCacheImpl implements LocalCache {
  static const token = 'userTokenId';
  static const user = "currentUser";

  late SecureStorage storage;
  late SharedPreferences sharedPreferences;

  LocalCacheImpl({
    required this.storage,
    required this.sharedPreferences,
  });

  @override
  Future<void> deleteToken() async {
    try {
      await storage.delete(token);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Object? getFromLocalCache(String key) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await storage.read(token);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await storage.write(key: token, value: token);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    AppLogger.logger.d('Data being saved: key: $key, value: $value');
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    if (value is Map) {
      await sharedPreferences.setString(key, json.encode(value));
    }
  }


  @override
  Future<void> cacheUserData({required String value}) async {
    await saveToLocalCache(key: user, value: value);
  }

  @override
  Future<void> deleteUserData() async {
    await removeFromLocalCache(user);
  }

  @override
  Future<Map<String, dynamic>> getUserData() async {
    var res = await getFromLocalCache(user) as String? ?? '{}';
    return Map<String, dynamic>.from(json.decode(res));
  }
}
