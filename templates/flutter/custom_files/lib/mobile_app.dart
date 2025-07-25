// ignore_for_file: use_build_context_synchronously

import 'config/deep_linking.dart';
import 'views/mobile/auth/login/login_screen.dart';
import 'views/mobile/main/home/home_screen.dart';
import 'views/mobile/components/material_apps/loading_material_app.dart';
import 'views/mobile/components/material_apps/main_material_app.dart';
import 'views/mobile/components/material_apps/no_data_material_app.dart';
import 'exceptions/known_exception.dart';
import 'services/user_service.dart';
import 'utilities/api.dart';
import 'utilities/global.dart';
import 'utilities/snackbars.dart';
import 'utilities/firebase.dart';
import 'utilities/user_secure_storage.dart';
import 'providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileApp extends StatefulWidget {
  const MobileApp({super.key});

  @override
  State<MobileApp> createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  late Future<Widget> _futureHomeScreen;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    Api.createDio();
    initDeepLinkListener();
    _futureHomeScreen = _getInitialScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _futureHomeScreen,
      builder: _buildFutureContent,
    );
  }

  /// Builds the UI based on the `Future<Widget>` state.
  ///
  /// Displays:
  /// - [LoadingMaterialApp] while fetching data
  /// - [MainMaterialApp] if data is available
  /// - [NoDataMaterialApp] if no data is found
  Widget _buildFutureContent(
    BuildContext context,
    AsyncSnapshot<Widget> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return LoadingMaterialApp();
    } else if (snapshot.hasData) {
      return MainMaterialApp(snapshot: snapshot);
    } else {
      return NoDataMaterialApp();
    }
  }

  /// Determines the initial screen of the application.
  ///
  /// If the user is authenticated, it returns [HomeScreen].
  /// Otherwise, it returns [LoginScreen].
  Future<Widget> _getInitialScreen() async {
    try {
      return await _handleGetInitialScreen();
    } on KnownException catch (e) {
      printOnDebug(e);
      showErrorSnackBar(context, e.toString());
    } catch (e) {
      printOnDebug(e);
    }
    return const LoginScreen();
  }

  /// Handles the logic to determine the initial screen.
  ///
  /// - If user data is available, it checks authentication.
  /// - If no user data is found, it redirects to [LoginScreen].
  Future<Widget> _handleGetInitialScreen() async {
    final userData = await _getUserData();

    if (userData != null) {
      return await _handleUserDataExists(userData);
    } else {
      return const LoginScreen();
    }
  }

  /// Checks if user data exists and determines the next screen.
  ///
  /// - If the user is valid, it loads the home screen.
  /// - If the user is not found, it redirects to authentication.
  Future<Widget> _handleUserDataExists(Map<String, dynamic> userData) async {
    final bool userExists = await _verifyUser(userData);

    if (userExists) {
      return await _loadUserAndGoHome(userData);
    } else {
      return await _unsetUserAndGoToAuthScreen();
    }
  }

  /// Clears stored user data and redirects to [LoginScreen].
  Future<Widget> _unsetUserAndGoToAuthScreen() async {
    await UserSecureStorage.unsetUserData();
    return const LoginScreen();
  }

  /// Loads the authenticated user and navigates to [HomeScreen].
  Future<Widget> _loadUserAndGoHome(Map<String, dynamic> userData) async {
    await _handleUserExists(userData);
    return HomeScreen();
  }

  /// Retrieves securely stored user data.
  ///
  /// Returns `null` if no user data is found.
  Future<Map<String, dynamic>?> _getUserData() async {
    final userData = await UserSecureStorage.getUserData();
    return userData['user'] != null ? userData : null;
  }

  /// Verifies if the user exists using the authentication token.
  Future<bool> _verifyUser(Map<String, dynamic> userData) async {
    Api.setBearerToken(userData['bearer_token']);
    return await UserService.checkUserExistsByBearerToken();
  }

  /// Handles authenticated user data by refreshing information and updating the FCM token.
  Future<void> _handleUserExists(Map<String, dynamic> userData) async {
    _userProvider.fromSecureStorage(userData);
    await _userProvider.user!.refresh();
    updateFCMToken(_userProvider);
  }
}
