import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../utilities/api.dart';

class UserProvider extends ChangeNotifier {
  String? id;
  String? bearerToken;
  bool isSuperAdmin = false;
  User? user;

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bearerToken = json['bearer_token'];
    isSuperAdmin = json['is_super_admin'] ?? false;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bearer_token': bearerToken,
      'is_super_admin': isSuperAdmin,
      'user': user?.toJson(),
    };
  }

  void unsetUser() {
    id = null;
    bearerToken = null;
    isSuperAdmin = false;
    user = null;

    notifyListeners();
  }

  Future<void> fromSecureStorage(Map<String, dynamic> userData) async {
    id = userData['id'];
    bearerToken = userData['bearer_token'];
    isSuperAdmin = userData['is_super_admin'] ?? false;
    user = userData['user'];
  }

  Future<void> fromCookie(Map<String, dynamic> cookieData) async {
    Api.setBearerToken(cookieData['bearer_token']);

    final User foundUser = await UserService.find(cookieData['id']);

    id = foundUser.id;
    bearerToken = cookieData['bearer_token'];
    isSuperAdmin = foundUser.isSuperAdmin;
    user = foundUser;
  }

  void notify() {
    notifyListeners();
  }

  bool isAuthenticated() {
    return id != null;
  }
}
