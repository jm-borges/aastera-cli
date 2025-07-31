import 'dart:convert';

import '../config/config.dart';
import 'strings.dart';
import 'package:universal_html/html.dart' as html;

class WebCookieStorage {
  static final String _cookieName =
      '${cleanSpecialCharacters(Config.appTitle.toLowerCase())}_user_data';

  static Future<String?> _getCookieValue(String name) async {
    final cookies = html.document.cookie;
    if (cookies == null) return null;

    final cookie = cookies
        .split('; ')
        .firstWhere(
          (String cookie) => cookie.startsWith('$name='),
          orElse: () => '',
        );

    if (cookie.isNotEmpty) {
      return cookie.substring(name.length + 1);
    }

    return null;
  }

  static Future<void> setUserData(String value) async {
    final expires = DateTime.now()
        .add(const Duration(days: 30))
        .toUtc()
        .toIso8601String();
    html.document.cookie = '$_cookieName=$value; expires=$expires; path=/';
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    String? cookie = await _getCookieValue(_cookieName);

    if (cookie != null) {
      return jsonDecode(cookie);
    }

    return null;
  }

  static Future<void> unsetUserData() async {
    final expires = DateTime.now()
        .subtract(const Duration(days: 1))
        .toUtc()
        .toIso8601String();
    html.document.cookie = '$_cookieName=; expires=$expires; path=/';
  }
}
