import 'package:flutter/material.dart';

class AppLogo extends StatefulWidget {
  final String orientation;

  const AppLogo({super.key, this.orientation = 'horizontal'});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.orientation == 'horizontal'
          ? 'assets/images/agro_sabio_horizontal.png'
          : 'assets/images/agro_sabio_vertical.png',
    );
  }
}
