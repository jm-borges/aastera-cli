import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'config/bugsnag.dart';
import 'config/firebase/firebase_initializer.dart';
import 'config/local_auth.dart';
import 'config/package_info.dart';
import 'config/providers.dart';
import 'mobile_app.dart';
import 'web_app.dart';

late final LocalAuthentication? auth;
bool canAuthenticateWithBiometrics = false;
List<BiometricType> availableBiometrics = [];
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeServices();

  const Widget app = kIsWeb ? WebApp() : MobileApp();

  runApp(MultiProvider(providers: providers, child: app));
}

Future<void> _initializeServices() async {
  await initializePackageInfo();
  await initializeBugsnag();
  await initializeFirebase();
  await initializeLocalAuth();
  await initializeDateFormatting('pt_BR');
}
