import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../config/routes/web_routes.dart';
import '../../../../config/theme_data.dart';
import '../../../../main.dart';

class MainMaterialApp extends StatefulWidget {
  final AsyncSnapshot<Widget> snapshot;

  const MainMaterialApp({super.key, required this.snapshot});

  @override
  State<MainMaterialApp> createState() => _MainMaterialAppState();
}

class _MainMaterialAppState extends State<MainMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      title: Config.appTitle,
      debugShowCheckedModeBanner: false,
      home: widget.snapshot.data!,
      routes: webRoutes,
    );
  }
}
