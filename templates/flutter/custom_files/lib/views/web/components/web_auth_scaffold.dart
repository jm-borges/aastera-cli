import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/loading_indicator.dart';

class WebAuthScaffold extends StatefulWidget {
  final Widget body;
  final bool resizeToAvoidBottomInset;

  const WebAuthScaffold({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  State<WebAuthScaffold> createState() => _WebAuthScaffoldState();
}

class _WebAuthScaffoldState extends State<WebAuthScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: Stack(children: [widget.body, _buildLoadingIndicator()]),
    );
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
}
