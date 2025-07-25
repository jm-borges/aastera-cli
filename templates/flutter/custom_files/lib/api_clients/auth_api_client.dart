import '../exceptions/api_limit_exception.dart';
import '../exceptions/duplicate_user_exception.dart';
import '../exceptions/invalid_credentials_exception.dart';
import '../exceptions/invalid_data_exception.dart';
import '../utilities/api.dart';

class AuthApiClient {
  static Future<dynamic> login(Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/login', data);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else if (response.statusCode == 401) {
        throw InvalidCredentialsException();
      } else if (response.statusCode == 422) {
        throw InvalidDataException(message: response.data['message']);
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> loginWithProvider(Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/auth/login/provider', data);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else if (response.statusCode == 401) {
        throw InvalidCredentialsException();
      } else if (response.statusCode == 422) {
        throw InvalidDataException(message: response.data['message']);
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> register(Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/register', data);
      if (response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 409) {
        throw DuplicateUserException();
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else if (response.statusCode == 422) {
        throw InvalidDataException(message: response.data['message']);
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> startPasswordReset(Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/password-reset/request', data);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else if (response.statusCode == 422) {
        throw InvalidDataException(message: response.data['message']);
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> resetPassword(Map<String, dynamic> data) async {
    try {
      final response = await Api.post(
        '/password-reset/password-reset/confirm',
        data,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else if (response.statusCode == 422) {
        throw InvalidDataException(message: response.data['message']);
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }
}
