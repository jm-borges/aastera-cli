import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../config/routes/web_routes.dart';
import '../../../../config/theme_data.dart';
import '../../../../main.dart';
import '../../auth/login/login_screen.dart';

class NoDataMaterialApp extends StatefulWidget {
  const NoDataMaterialApp({super.key});

  @override
  State<NoDataMaterialApp> createState() => _NoDataMaterialAppState();
}

class _NoDataMaterialAppState extends State<NoDataMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      title: Config.appTitle,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: webRoutes,
    );
  }
}
