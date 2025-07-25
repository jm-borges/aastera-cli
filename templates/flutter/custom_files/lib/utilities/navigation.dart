// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../config/routes/web_routes.dart';
import '../views/web/auth/login/login_screen.dart';
import '../utilities/user_secure_storage.dart';
import '../utilities/web_cookie_storage.dart';
import '../utilities/api.dart';
import '../utilities/firebase.dart';
import '../models/user.dart';

Route<dynamic>? handleWebRouteGeneration(
  RouteSettings settings,
  UserProvider userProvider,
) {
  return _handleRoute(settings, userProvider);
}

Route<dynamic>? _handleRoute(
  RouteSettings settings,
  UserProvider userProvider,
) {
  if (!userProvider.isAuthenticated() &&
      !publicRoutes.contains(settings.name)) {
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  }

  final WidgetBuilder? builder = webRoutes[settings.name];
  if (builder != null) {
    return MaterialPageRoute(builder: builder);
  }

  return _handleRouteNotFound();
}

Route<dynamic>? _handleRouteNotFound() {
  return MaterialPageRoute(builder: (context) => const LoginScreen());
}

Future<void> updateAuthenticatedUser(
  BuildContext context,
  User user,
  String token,
) async {
  UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  _updateUserProvider(userProvider, user, token);
  await _updateSecureStorage(userProvider);
  updateFCMToken(userProvider);
}

Future<void> _updateUserProvider(
  UserProvider userProvider,
  User user,
  String token,
) async {
  Api.setBearerToken(token);
  userProvider.id = user.id;
  userProvider.user = user;
  userProvider.bearerToken = token;
}

Future<void> _updateSecureStorage(UserProvider userProvider) async {
  if (kIsWeb) {
    await _setCookieStorageWithUserData(userProvider);
  } else {
    await _setSecureStorageWithUserData(userProvider);
  }
}

Future<void> _setCookieStorageWithUserData(UserProvider userProvider) async {
  await WebCookieStorage.setUserData(
    jsonEncode({
      'id': userProvider.id,
      'bearer_token': userProvider.bearerToken,
    }),
  );
}

Future<void> _setSecureStorageWithUserData(UserProvider userProvider) async {
  await UserSecureStorage.setUserData({
    'id': userProvider.id,
    'bearer_token': userProvider.bearerToken,
    'user': userProvider.user,
  });
}
