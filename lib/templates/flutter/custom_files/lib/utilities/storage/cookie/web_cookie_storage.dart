import 'package:universal_html/html.dart' as html;

class WebCookieStorage {
  static Future<String?> getCookieValue(String name) async {
    final cookies = html.document.cookie;
    if (cookies == null) return null;

    final cookie = cookies.split('; ').firstWhere(
          (c) => c.startsWith('$name='),
          orElse: () => '',
        );

    return cookie.isNotEmpty ? cookie.substring(name.length + 1) : null;
  }

  static Future<void> setCookie(
      String name, String value, Duration duration) async {
    final expires = DateTime.now().add(duration).toUtc().toIso8601String();
    html.document.cookie = '$name=$value; expires=$expires; path=/';
  }

  static Future<void> unsetCookie(String name) async {
    final expires = DateTime.now()
        .subtract(const Duration(days: 1))
        .toUtc()
        .toIso8601String();
    html.document.cookie = '$name=; expires=$expires; path=/';
  }
}
