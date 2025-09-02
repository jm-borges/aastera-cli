// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'app_bottom_navigation_bar.dart';
import 'loading_indicator_consumer.dart';
import 'scaffold_drawer.dart';
import 'top_app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: _buildTopAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildBody() {
    return Stack(children: [widget.body, _buildLoadingIndicator()]);
  }

  Widget _buildDrawer() {
    return ScaffoldDrawer();
  }

  Widget _buildLoadingIndicator() {
    return LoadingIndicatorConsumer();
  }

  PreferredSizeWidget _buildTopAppBar() {
    return TopAppBar();
  }

  Widget _buildBottomAppBar() {
    return AppBottomNavigationBar(scaffoldKey: _key);
  }
}
