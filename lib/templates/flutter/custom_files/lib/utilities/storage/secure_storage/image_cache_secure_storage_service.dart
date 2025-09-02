import '../../../utilities/global.dart';
import '../../../utilities/storage/secure_storage/secure_storage.dart';

class ImageCacheSecureStorageService {
  static const String _imagePrefix = 'imageCache_';
  static const String _keyListStorage = 'key_list_storage';

  static List<String> _keyList = [];

  /// Inicializa a lista de chaves armazenadas.
  static Future<void> initialize() async {
    try {
      final storedKeys = await SecureStorage.read(_keyListStorage);
      if (storedKeys != null && storedKeys.isNotEmpty) {
        _keyList = storedKeys.split(',');
      }
    } catch (e) {
      printOnDebug('Erro ao inicializar a lista de chaves: $e');
    }
  }

  /// Salva uma imagem em cache usando uma chave personalizada.
  static Future<void> setImage(String key, String base64Image) async {
    final storageKey = '$_imagePrefix$key';

    try {
      await SecureStorage.write(storageKey, base64Image);
      await _addKey(storageKey);
    } catch (e) {
      printOnDebug('Erro ao salvar imagem no cache: $e');
    }
  }

  /// Recupera uma imagem do cache.
  static Future<String?> getImage(String key) async {
    final storageKey = '$_imagePrefix$key';

    try {
      return await SecureStorage.read(storageKey);
    } catch (e) {
      printOnDebug('Erro ao recuperar imagem do cache: $e');
      return null;
    }
  }

  /// Remove todas as imagens do cache.
  static Future<void> clearCache() async {
    try {
      for (final key in _keyList.where((k) => k.startsWith(_imagePrefix))) {
        await SecureStorage.delete(key);
        printOnDebug('Imagem removida: $key');
      }

      await _clearKeyList();
      printOnDebug('Cache de imagens limpo com sucesso');
    } catch (e) {
      printOnDebug('Erro ao limpar o cache de imagens: $e');
    }
  }

  /// Retorna todas as chaves usadas no cache.
  static List<String> getAllKeys() => List.unmodifiable(_keyList);

  // ==== Métodos internos ====

  static Future<void> _addKey(String key) async {
    if (_keyList.contains(key)) return;

    _keyList.add(key);
    await _updateStoredKeyList();
  }

  static Future<void> _clearKeyList() async {
    _keyList.clear();
    await SecureStorage.delete(_keyListStorage);
  }

  static Future<void> _updateStoredKeyList() async {
    await SecureStorage.write(_keyListStorage, _keyList.join(','));
  }
}
