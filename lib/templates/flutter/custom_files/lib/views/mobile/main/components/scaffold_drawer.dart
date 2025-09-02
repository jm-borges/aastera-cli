import 'package:flutter/material.dart';
import '../../../../utilities/global.dart';
import '../../../../utilities/user.dart';

class ScaffoldDrawer extends StatefulWidget {
  const ScaffoldDrawer({super.key});

  @override
  State<ScaffoldDrawer> createState() => _ScaffoldDrawerState();
}

class _ScaffoldDrawerState extends State<ScaffoldDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: _buildDrawerItems()),
    );
  }

  List<Widget> _buildDrawerItems() {
    return [
      _buildDrawerHeader(),
      _buildHomeDrawerItem(),
      _buildChatDrawerItem(),
      _buildMyAccountDrawerItem(),
      _buildLogoutDrawerItem(),
    ];
  }

  Widget _buildHomeDrawerItem() {
    return _buildDrawerItem(
      icon: Icons.home,
      text: 'Início',
      onTap: () => Navigator.of(context).pushNamed('/home'),
    );
  }

  Widget _buildChatDrawerItem() {
    return _buildDrawerItem(
      icon: Icons.chat,
      text: 'Conversar',
      onTap: () => Navigator.of(context).pushNamed('/chat'),
    );
  }

  Widget _buildMyAccountDrawerItem() {
    return _buildDrawerItem(
      icon: Icons.person,
      text: 'Minha conta',
      onTap: () => Navigator.of(context).pushNamed('/account'),
    );
  }

  Widget _buildLogoutDrawerItem() {
    return _buildDrawerItem(
      icon: Icons.logout,
      text: 'Sair',
      onTap: _handleLogout,
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Theme.of(context).focusColor),
      child: _buildDrawerHeaderContent(),
    );
  }

  Widget _buildDrawerHeaderContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildMenuTitle(), _buildCloseIconButton()],
    );
  }

  Widget _buildMenuTitle() {
    return const Text(
      'Menu',
      style: TextStyle(color: Colors.white, fontSize: 24),
    );
  }

  Widget _buildCloseIconButton() {
    return IconButton(
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(text), onTap: onTap);
  }

  Future<void> _handleLogout() async {
    await executeAction(() async => await logout(context), context);
  }
}
