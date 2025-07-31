// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../config/theme_data.dart';
import '../main/home/home_screen.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppBottomNavigationBar({super.key, required this.scaffoldKey});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.focusColor,
        border: Border(top: BorderSide(color: Color(0xFF9BA5D0))),
      ),
      height: kBottomNavigationBarHeight * 1.2,
      child: Row(children: _buildNavItems()),
    );
  }

  List<Widget> _buildNavItems() {
    return [_buildHomeItem()];
  }

  Widget _buildHomeItem() {
    return _buildNavItem(
      icon: const Icon(Icons.home, size: 30, color: Colors.white),
      index: 1,
      onTap: _handleHomeNavigate,
    );
  }

  void _handleHomeNavigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget _buildNavItem({
    required Widget icon,
    required int index,
    String? label,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: () => _iconTap(onTap),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _buildNavItemContent(label: label, icon: icon),
      ),
    );
  }

  Widget _buildNavItemContent({required Widget icon, String? label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, if (label != null) _buildLabel(label)],
    );
  }

  void _iconTap(void Function()? onTap) {
    if (onTap != null) {
      onTap();
    }
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 10),
    );
  }
}
