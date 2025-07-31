import 'package:dio/dio.dart';

import '../exceptions/api_limit_exception.dart';
import '../exceptions/not_found_exception.dart';
import '../utilities/api.dart';
import '../utilities/global.dart';

class UserApiClient {
  static Future<List<dynamic>> get({String? email}) async {
    try {
      final Map<String, dynamic> queryParameters = {};

      if (email != null) {
        queryParameters['email'] = email;
      }

      final response = await Api.get(
        '/users',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> find(String id) async {
    try {
      final response = await Api.get('/users/$id');

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> create(Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/users', data);
      if (response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> update(String id, Map<String, dynamic> data) async {
    try {
      final response = await Api.put('/users/$id', data);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 429) {
        throw ApiLimitException();
      } else {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> delete(String id) async {
    try {
      final response = await Api.delete('/users/$id');
      if (response.statusCode != 200) {
        throw Exception(
          'A solicitação não foi concluída com sucesso. Foi recebido o código: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> uploadFile({
    required String id,
    required MultipartFile file,
    String collectionName = 'default',
  }) async {
    final response = await Api.post(
      '/attachment',
      FormData.fromMap({
        'model': 'App\\Models\\User',
        'model_id': id,
        'file': file,
        'collection_name': collectionName,
      }),
    );

    if (response.statusCode != 200) {
      printOnDebug(
        'File was not uploaded successfully. Status code: ${response.statusCode}',
      );
    }
  }

  static Future<void> removeFiles({
    required String id,
    String collectionName = 'default',
  }) async {
    final response = await Api.delete(
      '/attachment',
      data: {
        'model': 'App\\Models\\User',
        'model_id': id,
        'collection_name': collectionName,
      },
    );

    if (response.statusCode != 200) {
      printOnDebug(
        'File was not removed successfully. Status code: ${response.statusCode}',
      );
    }
  }

  static Future<bool> checkUserExistsByBearerToken() async {
    try {
      final response = await Api.get('/users/');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
}
