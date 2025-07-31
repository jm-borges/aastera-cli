import 'dart:convert';
import '../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'global.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyId = 'id';
  static const _keyBearerToken = 'bearer_token';
  static const _keyIsSuperAdmin = 'is_super_admin';
  static const _keyUser = 'user';
  static const _keyImages = 'imageCache_';
  static const _keyListStorage = 'key_list_storage';
  static List<String> _keyList = [];

  //=============================

  static Future<void> setId(String? id) async =>
      await _storage.write(key: _keyId, value: id);

  static Future<void> setBearerToken(String? token) async =>
      await _storage.write(key: _keyBearerToken, value: token);

  static Future<void> setIsSuperAdmin(bool? isSuperAdmin) async {
    await _storage.write(key: _keyIsSuperAdmin, value: isSuperAdmin.toString());
  }

  static Future<void> setUser(User? user) async {
    await _storage.write(key: _keyUser, value: jsonEncode(user?.toJson()));
  }

  //=============================

  static Future unsetId() async => await _storage.delete(key: _keyId);

  static Future unsetBearerToken() async =>
      await _storage.delete(key: _keyBearerToken);

  static Future unsetIsSuperAdmin() async {
    await _storage.delete(key: _keyIsSuperAdmin);
  }

  static Future unsetUser() async {
    await _storage.delete(key: _keyUser);
  }

  //=============================

  static Future<String?> getId() async {
    return await _storage.read(key: _keyId);
  }

  static Future<String?> getBearerToken() async =>
      await _storage.read(key: _keyBearerToken);

  static Future<bool> getIsSuperAdmin() async {
    String? result = await _storage.read(key: _keyIsSuperAdmin);
    if (result != null) {
      return bool.parse(result);
    }

    return false;
  }

  static Future<User?> getUser() async {
    String? userJson = await _storage.read(key: _keyUser);

    if (userJson == null || userJson == 'null') {
      return null;
    }

    return User.fromJson(jsonDecode(userJson));
  }

  //=============================

  static Future setUserData(Map<String, dynamic> data) async {
    await UserSecureStorage.setId(data['id']);
    await UserSecureStorage.setBearerToken(data['bearer_token']);
    await UserSecureStorage.setIsSuperAdmin(data['is_super_admin']);
    await UserSecureStorage.setUser(data['user']);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final String? id = await UserSecureStorage.getId();
    final String? bearerToken = await UserSecureStorage.getBearerToken();
    final bool isSuperAdmin = await UserSecureStorage.getIsSuperAdmin();
    final User? user = await UserSecureStorage.getUser();

    Map<String, dynamic> userData = {
      'id': id,
      'bearer_token': bearerToken,
      'is_super_admin': isSuperAdmin,
      'user': user,
    };

    return userData;
  }

  static Future unsetUserData() async {
    await UserSecureStorage.unsetId();
    await UserSecureStorage.unsetBearerToken();
    await UserSecureStorage.unsetIsSuperAdmin();
    await UserSecureStorage.unsetUser();
  }

  //====================== CACHE FUNCTIONS ===========================================

  static Future<void> setImageCache(String key, String base64Image) async {
    try {
      String finalKey = '$_keyImages$key';
      await _storage.write(key: finalKey, value: base64Image);

      await _addKeyToList(finalKey);
    } catch (e) {
      printOnDebug('Erro ao salvar imagem no cache: $e');
    }
  }

  static Future<String?> getImageCache(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      printOnDebug('Erro ao recuperar imagem do cache: $e');
      return null;
    }
  }

  static Future<void> clearImageCache() async {
    try {
      for (var key in _keyList) {
        if (key.startsWith('imageCache_')) {
          printOnDebug('Chave da imagem a ser removida $key');
          await _storage.delete(key: key);
        }
      }

      await _clearKeyList();
      printOnDebug('Cache de imagens limpo com sucesso');
    } catch (e) {
      printOnDebug('Erro ao limpar o cache: $e');
    }
  }

  static Future<List<String>> getAllKeys() async {
    try {
      return _keyList;
    } catch (e) {
      printOnDebug('Erro ao recuperar as chaves: $e');
      return [];
    }
  }

  static Future<void> _addKeyToList(String key) async {
    try {
      if (!_keyList.contains(key)) {
        _keyList.add(key);

        await _storage.write(key: _keyListStorage, value: _keyList.join(','));
      }
    } catch (e) {
      printOnDebug('Erro ao adicionar chave à lista: $e');
    }
  }

  static Future<void> _clearKeyList() async {
    try {
      _keyList.clear();
      await _storage.delete(key: _keyListStorage);
    } catch (e) {
      printOnDebug('Erro ao limpar a lista de chaves: $e');
    }
  }

  static Future<void> loadKeyList() async {
    try {
      String? storedKeys = await _storage.read(key: _keyListStorage);
      if (storedKeys != null) {
        _keyList = storedKeys.split(',').toList();
      }
    } catch (e) {
      printOnDebug('Erro ao carregar a lista de chaves: $e');
    }
  }
}
