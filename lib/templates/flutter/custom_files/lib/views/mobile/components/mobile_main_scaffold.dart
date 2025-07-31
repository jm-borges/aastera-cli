// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme_data.dart';
import '../../../providers/loading_indicator.dart';
import 'app_bottom_navigation_bar.dart';
import '../../../utilities/global.dart';
import '../../../utilities/user.dart';

class MobileMainScaffold extends StatefulWidget {
  final Widget body;
  final bool showAppBar;
  final String? title;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;

  const MobileMainScaffold({
    super.key,
    required this.body,
    this.showAppBar = true,
    this.title,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
  });

  @override
  State<MobileMainScaffold> createState() => _MobileMainScaffoldState();
}

class _MobileMainScaffoldState extends State<MobileMainScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late LoadingIndicator _loadingIndicator;

  @override
  void initState() {
    _loadingIndicator = Provider.of<LoadingIndicator>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: Stack(children: [widget.body, _buildLoadingIndicator()]),
      bottomNavigationBar: AppBottomNavigationBar(scaffoldKey: _key),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: _buildDrawerItems()),
    );
  }

  List<Widget> _buildDrawerItems() {
    return [
      _buildDrawerHeader(),
      _buildHomeDrawerItem(),
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
      decoration: BoxDecoration(color: themeData.focusColor),
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

  Widget _buildLoadingIndicator() {
    return Consumer<LoadingIndicator>(builder: _loadingIndicatorBuilder);
  }

  Widget _loadingIndicatorBuilder(
    BuildContext context,
    LoadingIndicator loadingIndicator,
    Widget? child,
  ) {
    if (loadingIndicator.isVisible) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      );
    } else {
      return Container();
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      backgroundColor: themeData.focusColor,

      actions: [_buildMyAccountButton()],
    );
  }

  Widget _buildMyAccountButton() {
    return GestureDetector(
      onTap: _handleMyAccountButtonTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Minha conta', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMyAccountButtonTap() {
    Navigator.pushNamed(context, '/account');
  }

  Future<void> _handleLogout() async {
    await executeAction(
      () async => await logout(context),
      _loadingIndicator,
      context,
    );
  }
}
