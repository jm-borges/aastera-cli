import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CursorGestureDetector extends GestureDetector {
  CursorGestureDetector({
    super.key,
    super.onTap,
    super.onTapDown,
    this.onHover,
    this.onExit,
    super.child,
  });

  final void Function(PointerHoverEvent)? onHover;
  final void Function(PointerExitEvent)? onExit;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      onExit: onExit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        onTapDown: onTapDown,
        child: child,
      ),
    );
  }
}
