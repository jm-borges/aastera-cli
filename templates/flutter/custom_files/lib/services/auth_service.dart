import '../api_clients/auth_api_client.dart';
import '../models/user.dart';
import '../utilities/global.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
    Map<String, dynamic> formData,
  ) async {
    try {
      dynamic data = await AuthApiClient.login(formData);
      return {'user': User.fromJson(data['user']), 'token': data['token']};
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> loginWithProvider({
    required String idToken,
  }) async {
    try {
      dynamic data = await AuthApiClient.loginWithProvider({
        'id_token_str': idToken,
      });

      return {'access_token': data['access_token']};
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> formData,
  ) async {
    try {
      dynamic data = await AuthApiClient.register(formData);
      return {'user': User.fromJson(data['user']), 'token': data['token']};
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<void> startPasswordReset(Map<String, dynamic> formData) async {
    try {
      await AuthApiClient.startPasswordReset(formData);
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<bool> resetPassword(Map<String, dynamic> formData) async {
    try {
      await AuthApiClient.resetPassword(formData);

      return true;
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }
}
