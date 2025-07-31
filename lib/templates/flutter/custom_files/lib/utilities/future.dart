import 'global.dart';
import 'package:flutter/material.dart';

class SimpleFutureBuilder<T> extends StatefulWidget {
  final Future<T> dataFuture;
  final Widget Function(AsyncSnapshot<T>) contentBuilder;
  final Color? loadingIndicatorColor;
  final Color? loadingIndicatorContainerColor;
  final double? loadingIndicatorContainerHeight;
  final double? loadingIndicatorContainerWidth;

  /// A reusable widget that simplifies the usage of Flutter's [FutureBuilder].
  ///
  /// The `SimpleFutureBuilder` takes a [Future] of type `T` and a [contentBuilder]
  /// function as parameters. The [contentBuilder] function is responsible for
  /// building the widget tree based on the [AsyncSnapshot<T>] received from the [Future].
  ///
  /// Example Usage:
  /// ```dart
  /// SimpleFutureBuilder<String>(
  ///   dataFuture: fetchData(),
  ///   contentBuilder: (AsyncSnapshot<String> snapshot) {
  ///     return Text('The data received is: ${snapshot.data}');
  ///   },
  /// )
  /// ```
  const SimpleFutureBuilder({
    super.key,
    required this.dataFuture,
    required this.contentBuilder,
    this.loadingIndicatorColor,
    this.loadingIndicatorContainerColor,
    this.loadingIndicatorContainerHeight,
    this.loadingIndicatorContainerWidth,
  });

  @override
  State<SimpleFutureBuilder<T>> createState() => _SimpleFutureBuilderState<T>();
}

class _SimpleFutureBuilderState<T> extends State<SimpleFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(future: widget.dataFuture, builder: _builder);
  }

  Widget _builder(BuildContext context, AsyncSnapshot<T> snapshot) {
    return FutureBuilderSnapshotHelper<T>(
      snapshot: snapshot,
      content: widget.contentBuilder,
      loadingIndicatorColor: widget.loadingIndicatorColor,
      loadingIndicatorContainerColor: widget.loadingIndicatorContainerColor,
      loadingIndicatorContainerHeight: widget.loadingIndicatorContainerHeight,
      loadingIndicatorContainerWidth: widget.loadingIndicatorContainerWidth,
    );
  }
}

class FutureBuilderSnapshotHelper<T> extends StatefulWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget Function(AsyncSnapshot<T>) content;
  final Color? loadingIndicatorColor;
  final Color? loadingIndicatorContainerColor;
  final double? loadingIndicatorContainerHeight;
  final double? loadingIndicatorContainerWidth;

  /// A convenient helper widget designed to simplify the usage of the `FutureBuilder` widget
  /// by abstracting away the common pattern of handling different states of the future snapshot.
  ///
  /// The `FutureBuilderSnapshotHelper` takes an `AsyncSnapshot<T>` and a `content` widget as its parameters.
  /// It automatically handles cases where the future is still loading, has an error, or has no data.
  /// In the case of a successful future, it renders the provided content widget.
  const FutureBuilderSnapshotHelper({
    super.key,
    required this.snapshot,
    required this.content,
    this.loadingIndicatorColor,
    this.loadingIndicatorContainerColor,
    this.loadingIndicatorContainerHeight,
    this.loadingIndicatorContainerWidth,
  });

  @override
  State<FutureBuilderSnapshotHelper<T>> createState() =>
      _FutureBuilderSnapshotHelperState<T>();
}

class _FutureBuilderSnapshotHelperState<T>
    extends State<FutureBuilderSnapshotHelper<T>> {
  @override
  Widget build(BuildContext context) {
    if (_isLoading(widget.snapshot)) {
      return _buildLoadingState();
    } else if (_hasError(widget.snapshot)) {
      return _buildErrorState(widget.snapshot);
    }

    return widget.content(widget.snapshot);
  }

  Widget _buildLoadingState() {
    final Color loadingColor =
        widget.loadingIndicatorColor ?? Theme.of(context).primaryColor;
    final Color containerColor =
        widget.loadingIndicatorContainerColor ?? Colors.black;

    return Container(
      width: widget.loadingIndicatorContainerWidth,
      height: widget.loadingIndicatorContainerHeight,
      color: containerColor,
      child: Center(child: CircularProgressIndicator(color: loadingColor)),
    );
  }

  Widget _buildErrorState(AsyncSnapshot<T> snapshot) {
    printOnDebug("Error while processing Future: ${snapshot.error}");
    return const Center(
      child: Text("There was an error while getting this data."),
    );
  }

  bool _isLoading(AsyncSnapshot<T> snapshot) {
    return snapshot.connectionState == ConnectionState.waiting;
  }

  bool _hasError(AsyncSnapshot<T> snapshot) {
    return snapshot.hasError;
  }
}

bool isLoading<T>(AsyncSnapshot<T> snapshot) {
  return snapshot.connectionState == ConnectionState.waiting;
}

/// Determines if the snapshot's data being `null` is a valid state.
/// By default, considers data `null` as invalid unless explicitly allowed for the type `T`.
bool snapshotDataCannotBeNull<T>(AsyncSnapshot<T> snapshot) {
  return T != Null;
}

bool snapshotIsWaiting<T>(AsyncSnapshot<T> snapshot) {
  return snapshot.connectionState == ConnectionState.waiting;
}
