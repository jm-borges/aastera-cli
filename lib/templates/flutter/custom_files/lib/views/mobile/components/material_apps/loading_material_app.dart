import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../config/routes/mobile_routes.dart';
import '../../../../config/theme_data.dart';

class LoadingMaterialApp extends StatefulWidget {
  const LoadingMaterialApp({super.key});

  @override
  State<LoadingMaterialApp> createState() => _LoadingMaterialAppState();
}

class _LoadingMaterialAppState extends State<LoadingMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      title: Config.appTitle,
      debugShowCheckedModeBanner: false,
      home: _buildCircularProgressIndicatorScaffold(),
      routes: mobileRoutes,
    );
  }

  Widget _buildCircularProgressIndicatorScaffold() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
