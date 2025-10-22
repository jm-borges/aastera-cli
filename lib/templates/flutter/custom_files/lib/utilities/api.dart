import 'dart:convert';
import 'package:dio/dio.dart';
import '../exceptions/no_connection_exception.dart';
import 'global.dart';
import '../config/config.dart';

/// A utility class for making HTTP requests using Dio.
class Api {
  static Dio? _dio;

  /// Gets the Dio instance with configured base URL and headers.
  static Dio get dio {
    _dio ??= _createDioInstance();
    return _dio!;
  }

  /// Creates a new Dio instance with default configurations.
  static Dio createDio() {
    _dio ??= _createDioInstance();
    return _dio!;
  }

  /// Configures and returns a new Dio instance.
  static Dio _createDioInstance() {
    final Dio dio = Dio();

    dio.options.baseUrl = Config.baseApiUrl;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    dio.options.validateStatus = (status) => true;

    return dio;
  }

  /// Checks if the Dio instance has a Bearer token in its headers.
  static bool hasBearerToken() {
    return dio.options.headers.containsKey('Authorization');
  }

  /// Sets a Bearer token in the Dio instance headers.
  static void setBearerToken(String? token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Sets the content type in the Dio instance headers.
  static void setContentType(String? contentType) {
    dio.options.headers['Content-Type'] = contentType ?? '';
  }

  /// Removes the Bearer token from the Dio instance headers.
  static void removeBearerToken() {
    dio.options.headers.remove('Authorization');
  }

  /// Makes an HTTP request using the specified method, endpoint, and data.
  static Future<Response> _makeRequest(
    String method,
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!(await internetConnectionExists())) {
      throw NoConnectionException();
    }

    try {
      final String url = '${_dio!.options.baseUrl}$endpoint';

      _printRequestInfo(method, url, data, queryParameters: queryParameters);

      Response response = await _performRequest(
        method,
        url,
        data,
        queryParameters: queryParameters,
      );

      _printResponseInfo(response);
      return response;
    } catch (error) {
      printOnDebug('Error making $method request: $error');
      rethrow;
    }
  }

  /// Prints information about the HTTP request.
  static void _printRequestInfo(
    String method,
    String url,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) {
    printOnDebug('API REQUEST ===========> $method $url');
    if (data != null && data is! FormData) {
      final String payload = jsonEncode(data).length > 150
          ? '${jsonEncode(data).substring(0, 150)}...'
          : jsonEncode(data);
      printOnDebug('API REQUEST PAYLOAD: $payload');
    }
    if (queryParameters != null) {
      printOnDebug('API REQUEST QUERY PARAMETERS: $queryParameters');
    }
  }

  /// Performs the HTTP request based on the specified method, URL, and data.
  static Future<Response> _performRequest(
    String method,
    String url,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) {
    switch (method) {
      case 'GET':
        return dio.get(url, queryParameters: queryParameters);
      case 'POST':
        return dio.post(url, data: data);
      case 'PUT':
        return dio.put(url, data: data);
      case 'PATCH':
        return dio.patch(url, data: data);
      case 'DELETE':
        return dio.delete(url, data: data);
      default:
        throw ArgumentError('Invalid HTTP method: $method');
    }
  }

  /// Prints information about the HTTP response.
  static void _printResponseInfo(Response response) {
    final String responseData = jsonEncode(response.data).length > 150
        ? '${jsonEncode(response.data).substring(0, 150)}...'
        : jsonEncode(response.data);
    printOnDebug(
      'API RESPONSE <============= ${response.statusCode}: $responseData',
    );
  }

  /// Makes a GET request to the specified endpoint.
  static Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _makeRequest(
      'GET',
      endpoint,
      null,
      queryParameters: queryParameters,
    );
  }

  /// Makes a POST request to the specified endpoint with the provided data.
  static Future<Response> post(String endpoint, dynamic data) async {
    return _makeRequest('POST', endpoint, data);
  }

  /// Makes a PUT request to the specified endpoint with the provided data.
  static Future<Response> put(String endpoint, dynamic data) async {
    return _makeRequest('PUT', endpoint, data);
  }

  /// Makes a PATCH request to the specified endpoint with the provided data.
  static Future<Response> patch(String endpoint, dynamic data) async {
    return _makeRequest('PATCH', endpoint, data);
  }

  /// Makes a DELETE request to the specified endpoint with optional data.
  static Future<Response> delete(String endpoint, {dynamic data}) async {
    return _makeRequest('DELETE', endpoint, data);
  }
}
