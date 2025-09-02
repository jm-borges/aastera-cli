import 'package:flutter/material.dart';
import '../../../../providers/loading_indicator.dart';
import 'package:provider/provider.dart';

class MobileAuthScaffold extends StatefulWidget {
  final Widget body;
  final bool resizeToAvoidBottomInset;

  const MobileAuthScaffold({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  State<MobileAuthScaffold> createState() => _MobileAuthScaffoldState();
}

class _MobileAuthScaffoldState extends State<MobileAuthScaffold> {
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
