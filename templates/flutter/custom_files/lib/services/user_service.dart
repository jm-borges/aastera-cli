import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../api_clients/user_api_client.dart';
import '../models/user.dart';
import '../utilities/global.dart';
import '../utilities/files.dart';

class UserService {
  static Future<List<User>> get({String? email}) async {
    try {
      List<dynamic> data = await UserApiClient.get(email: email);
      return data.map((json) => User.fromJson(json)).toList();
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<User> find(String id) async {
    try {
      dynamic data = await UserApiClient.find(id);
      return User.fromJson(data);
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<User> create(Map<String, dynamic> formData) async {
    try {
      dynamic data = await UserApiClient.create(formData);
      return User.fromJson(data);
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<User> update(Map<String, dynamic> formData, String id) async {
    try {
      dynamic data = await UserApiClient.update(id, formData);
      return User.fromJson(data);
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<void> delete(String id) async {
    try {
      await UserApiClient.delete(id);
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<void> uploadPhoto({
    required String id,
    required PlatformFile originalFile,
  }) async {
    try {
      MultipartFile processedFile = await createMultipartFile(originalFile);

      await UserApiClient.uploadFile(
        id: id,
        file: processedFile,
        collectionName: 'profile_image',
      );
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<void> removePhoto({required String id}) async {
    try {
      await UserApiClient.removeFiles(id: id, collectionName: 'profile_image');
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }

  static Future<bool> checkUserExistsByBearerToken() async {
    try {
      return await UserApiClient.checkUserExistsByBearerToken();
    } catch (error) {
      printOnDebug(error);
      rethrow;
    }
  }
}
