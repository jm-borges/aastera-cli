// lib/services/cookie/user_cookie_service.dart
import 'dart:convert';
import '../../../utilities/storage/cookie/web_cookie_storage.dart';
import '../../../config/config.dart';
import '../../../utilities/strings.dart';

class UserCookieService {
  static final String _baseName = cleanSpecialCharacters(
    Config.appTitle.toLowerCase(),
  );
  static final String _cookieName = '${_baseName}_user_data';

  static Future<void> setUserData(String value) async {
    await WebCookieStorage.setCookie(
      _cookieName,
      value,
      const Duration(days: 30),
    );
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final value = await WebCookieStorage.getCookieValue(_cookieName);
    return value != null ? jsonDecode(value) : null;
  }

  static Future<void> unsetUserData() async {
    await WebCookieStorage.unsetCookie(_cookieName);
  }
}
