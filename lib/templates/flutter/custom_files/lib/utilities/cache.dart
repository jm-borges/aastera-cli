import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'global.dart';
import 'storage/secure_storage/image_cache_secure_storage_service.dart';

class CustomImageCache {
  Future<void> saveImageToCache(String url, List<int> bytes) async {
    final String jsonBytes = base64.encode(bytes);
    if (!kIsWeb) {
      await ImageCacheSecureStorageService.setImage(url, jsonBytes);
    }
  }

  Future<List<int>?> getImageFromCache(String url) async {
    if (!kIsWeb) {
      final String? base64Bytes = await ImageCacheSecureStorageService.getImage(
        url,
      );
      if (base64Bytes != null) {
        return base64.decode(base64Bytes);
      }
    }
    return null;
  }

  Future<void> clearCache() async {
    try {
      await ImageCacheSecureStorageService.clearCache();
    } catch (e) {
      printOnDebug('Erro ao limpar o cache: $e');
    }
  }
}
