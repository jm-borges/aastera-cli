// lib/services/storage/user_secure_storage_service.dart
import 'dart:convert';
import '../../../utilities/storage/secure_storage/secure_storage.dart';
import '../../../models/user.dart';

class UserSecureStorageService {
  static const _keyId = 'id';
  static const _keyBearerToken = 'bearer_token';
  static const _keyIsSuperAdmin = 'is_super_admin';
  static const _keyUser = 'user';

  // ---------------------- SETTERS INDIVIDUAIS ----------------------

  static Future<void> setId(String? id) async =>
      await SecureStorage.write(_keyId, id ?? '');

  static Future<void> setBearerToken(String? token) async =>
      await SecureStorage.write(_keyBearerToken, token ?? '');

  static Future<void> setIsSuperAdmin(bool? value) async =>
      await SecureStorage.write(_keyIsSuperAdmin, (value ?? false).toString());

  static Future<void> setUser(User? user) async {
    if (user == null) {
      await SecureStorage.delete(_keyUser);
    } else {
      await SecureStorage.write(_keyUser, jsonEncode(user.toJson()));
    }
  }

  // ---------------------- GETTERS INDIVIDUAIS ----------------------

  static Future<String> getId() async =>
      (await SecureStorage.read(_keyId)) ?? '';

  static Future<String> getBearerToken() async =>
      (await SecureStorage.read(_keyBearerToken)) ?? '';

  static Future<bool> getIsSuperAdmin() async =>
      (await SecureStorage.read(_keyIsSuperAdmin)) == 'true';

  static Future<User?> getUser() async {
    final jsonStr = await SecureStorage.read(_keyUser);
    try {
      return jsonStr != null ? User.fromJson(jsonDecode(jsonStr)) : null;
    } catch (_) {
      return null;
    }
  }

  // ---------------------- SET & GET COMPLETOS ----------------------

  static Future<void> setUserData(Map<String, dynamic> data) async {
    await setId(data['id']?.toString());
    await setBearerToken(data['bearer_token']?.toString());
    await setIsSuperAdmin(data['is_super_admin'] ?? false);
    await setUser(data['user']);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    return {
      'id': await getId(),
      'bearer_token': await getBearerToken(),
      'is_super_admin': await getIsSuperAdmin(),
      'user': await getUser(),
    };
  }

  // ---------------------- LIMPAR TUDO ----------------------

  static Future<void> clearUserData() async {
    await SecureStorage.delete(_keyId);
    await SecureStorage.delete(_keyBearerToken);
    await SecureStorage.delete(_keyIsSuperAdmin);
    await SecureStorage.delete(_keyUser);
  }
}
