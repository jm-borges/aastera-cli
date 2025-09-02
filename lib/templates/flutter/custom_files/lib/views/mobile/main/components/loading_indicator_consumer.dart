import 'package:flutter/material.dart';
import '../../../../providers/loading_indicator.dart';
import 'package:provider/provider.dart';

class LoadingIndicatorConsumer extends StatefulWidget {
  const LoadingIndicatorConsumer({super.key});

  @override
  State<LoadingIndicatorConsumer> createState() =>
      _LoadingIndicatorConsumerState();
}

class _LoadingIndicatorConsumerState extends State<LoadingIndicatorConsumer> {
  @override
  Widget build(BuildContext context) {
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
