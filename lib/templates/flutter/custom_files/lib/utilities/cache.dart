import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'global.dart';
import 'user_secure_storage.dart';

class CustomImageCache {
  Future<void> saveImageToCache(String url, List<int> bytes) async {
    final String jsonBytes = base64.encode(bytes);
    if (!kIsWeb) {
      await UserSecureStorage.setImageCache(url, jsonBytes);
    }
  }

  Future<List<int>?> getImageFromCache(String url) async {
    if (!kIsWeb) {
      final String? base64Bytes = await UserSecureStorage.getImageCache(url);
      if (base64Bytes != null) {
        return base64.decode(base64Bytes);
      }
    }
    return null;
  }

  Future<void> clearCache() async {
    try {
      await UserSecureStorage.clearImageCache();
    } catch (e) {
      printOnDebug('Erro ao limpar o cache: $e');
    }
  }
}
