// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/config.dart';
import 'config/deep_linking.dart';
import 'config/routes/web_routes.dart';
import 'config/theme_data.dart';
import 'exceptions/known_exception.dart';
import 'main.dart';
import 'providers/user_provider.dart';
import 'services/user_service.dart';
import 'utilities/navigation.dart';
import 'utilities/api.dart';
import 'utilities/firebase.dart';
import 'utilities/global.dart';
import 'utilities/snackbars.dart';
import 'utilities/storage/cookie/user_cookie_service.dart';
import 'views/web/auth/login/login_screen.dart';
import 'views/web/main/home/home_screen.dart';

class WebApp extends StatefulWidget {
  const WebApp({super.key});

  @override
  State<WebApp> createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> {
  late Future<Widget> _futureHomeScreen;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _initProviders();
    Api.createDio();
    initDeepLinkListener();
    _futureHomeScreen = _getInitialScreen();
  }

  @override
  void dispose() {
    linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _futureHomeScreen,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingMaterialApp();
        } else if (snapshot.hasData) {
          return _buildMaterialApp(snapshot.data!, webRoutes);
        } else {
          return _buildNoDataMaterialApp();
        }
      },
    );
  }

  /// Builds a `MaterialApp` widget that displays a loading indicator.
  ///
  /// This method returns a `MaterialApp` with a loading screen scaffold, which
  /// consists of a centered `CircularProgressIndicator` on a white background.
  /// The `mobileRoutes` are provided to the `MaterialApp` for navigation.
  ///
  /// Returns:
  /// - `Widget`: A `MaterialApp` widget with a loading indicator.
  Widget _buildLoadingMaterialApp() {
    return _buildMaterialApp(_buildLoadingScaffold(), webRoutes);
  }

  /// Builds a `Scaffold` widget to display a loading indicator.
  ///
  /// This method returns a `Scaffold` widget with a white background and a
  /// centered `CircularProgressIndicator`, indicating that a loading process
  /// is occurring.
  ///
  /// Returns:
  /// - `Widget`: A `Scaffold` widget with a loading indicator.
  Widget _buildLoadingScaffold() {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }

  /// Builds a `MaterialApp` widget that displays a pre-authentication screen.
  ///
  /// This method returns a `MaterialApp` that presents the `LoginScreen`
  /// widget, indicating that no user data is available yet. The `mobileRoutes` are
  /// provided to the `MaterialApp` for navigation.
  ///
  /// Returns:
  /// - `Widget`: A `MaterialApp` widget displaying the `LoginScreen`.
  Widget _buildNoDataMaterialApp() {
    return _buildMaterialApp(const LoginScreen(), webRoutes);
  }

  /// Builds a `MaterialApp` widget with the specified home screen and routes.
  ///
  /// This method constructs a `MaterialApp` with custom configuration such as
  /// the app's theme, title, and a navigator key for controlling navigation.
  /// It takes a `home` widget, which will be the main screen of the app, and
  /// a map of `routes` to define the available navigation paths within the app.
  ///
  /// Parameters:
  /// - [home]: A `Widget` that serves as the app's main screen.
  /// - [routes]: A `Map<String, WidgetBuilder>` defining the available routes
  ///   and their corresponding screens.
  ///
  /// Returns:
  /// - `MaterialApp`: A configured `MaterialApp` widget with the given home
  ///   screen and routes.
  Widget _buildMaterialApp(Widget home, Map<String, WidgetBuilder> routes) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      title: Config.appTitle,
      debugShowCheckedModeBanner: false,
      home: home,
      onGenerateRoute: (RouteSettings settings) =>
          handleWebRouteGeneration(settings, _userProvider),
    );
  }

  /// Determines and returns the initial screen widget to display based on user data.
  ///
  /// This method retrieves user data from secure storage to determine if the user
  /// is already authenticated. If valid user data is found, it calls
  /// `_handleUserDataExists` to handle the user setup and returns the appropriate
  /// screen. If an error occurs during this process, it catches and handles
  /// specific known exceptions by showing an error message in a snack bar. For any
  /// other exception, it logs the error for debugging purposes.
  ///
  /// If no user data is found or an error occurs, the method returns the
  /// `LoginScreen`, which is the screen displayed before the user logs in.
  ///
  /// Returns:
  /// - `Future<Widget>`: A `Future` that resolves to the initial screen widget.
  ///
  /// Exceptions:
  /// - `KnownException`: If a known error occurs, it shows an error message using
  ///   `showErrorSnackBar`.
  /// - Any other exception is caught and logged for debugging.
  Future<Widget> _getInitialScreen() async {
    try {
      final Map<String, dynamic> userData =
          await UserCookieService.getUserData() ?? {};

      if (userData['id'] != null) {
        return await _handleUserDataExists(userData);
      }
    } on KnownException catch (e) {
      printOnDebug(e);
      showErrorSnackBar(context, e.toString());
    } catch (e) {
      printOnDebug(e);
    }

    return const LoginScreen();
  }

  /// Handles user data when a bearer token is present and verifies user existence.
  ///
  /// This method processes user data when it is found in secure storage. It sets the
  /// bearer token for the `Api` service, then verifies if the user exists by calling
  /// `UserService.checkUserExistsByBearerToken()`. If the user exists:
  ///
  /// 1. Calls `_handleUserExists(userData)` to set up the user.
  /// 2. Returns the appropriate screen widget by calling `_getAppropriateScreen()`.
  ///
  /// If the user does not exist (i.e., the bearer token is invalid or expired),
  /// it clears the user data from secure storage by calling `UserSecureStorage.unsetUserData()`,
  /// and returns the `LoginScreen`.
  ///
  /// Parameters:
  /// - [userData]: A `Map<String, dynamic>` containing the user's data, including the bearer token.
  ///
  /// Returns:
  /// - `Future<Widget>`: A `Future` that resolves to the appropriate screen widget based on
  ///   whether the user exists or not.
  Future<Widget> _handleUserDataExists(Map<String, dynamic> userData) async {
    Api.setBearerToken(userData['bearer_token']);
    final bool userExists = await UserService.checkUserExistsByBearerToken();

    if (userExists) {
      await executeAction(
        () async => await _handleUserExists(userData),
        context,
      );

      return HomeScreen();
    } else {
      UserCookieService.unsetUserData();
    }

    return const LoginScreen();
  }

  /// Handles the process when an existing user is identified in the app.
  ///
  /// This method performs a series of asynchronous tasks to set up the user
  /// when they are already registered or authenticated. It ensures that user
  /// permissions, data, and tokens are up-to-date. The steps include:
  ///
  /// 1. **Refresh User Permissions**: Calls `refreshPermissions` on the
  ///    `_permissionProvider` to ensure the user's permissions are current.
  /// 2. **Load User Data**: Retrieves the user's data from secure storage by
  ///    calling `fromSecureStorage` on the `_userProvider`, passing the provided
  ///    `userData`.
  /// 3. **Refresh User Information**: Calls `refresh` on the user object to
  ///    ensure the latest information is loaded.
  /// 4. **Update FCM Token**: Calls `updateFCMToken` to update the Firebase
  ///    Cloud Messaging (FCM) token for push notifications.
  ///
  /// This method is asynchronous and returns a `Future<void>` that completes
  /// once all tasks are finished.
  ///
  /// Parameters:
  /// - [userData]: A `Map<String, dynamic>` containing the user's data from
  ///   secure storage.
  Future<void> _handleUserExists(Map<String, dynamic> userData) async {
    await _userProvider.fromCookie(userData);
    await _userProvider.user!.refresh();
    updateFCMToken(_userProvider);
  }

  /// Initializes the provider instances used within the application.
  ///
  /// This method retrieves and assigns instances of several providers to
  /// class-level variables. The providers are fetched from the widget tree
  /// using the `Provider.of` method from the `provider` package, ensuring that
  /// the method does not rebuild the widgets when the provider changes by
  /// setting `listen` to `false`.
  ///
  ///
  /// The method must be called in a context where the providers have already
  /// been added to the widget tree, such as within an `initState` method.
  ///
  void _initProviders() {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }
}
