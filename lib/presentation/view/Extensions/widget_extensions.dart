import 'package:flutter/material.dart';

typedef GestureOnTapChangeCallback = void Function(bool tapState);

extension StyledWidget on Widget {
  Widget parent(Widget Function({required Widget child}) parent) =>
      parent(child: this);

  Widget onTap({GestureTapCallback? onTap}) => InkWell(
        onTap: onTap,
        child: this,
      );

  Widget gestures({
    GestureOnTapChangeCallback? onTapChange,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
  }) =>
      GestureDetector(
        onTap: () {
          if (onTap != null) onTap();
          if (onTapChange != null) onTapChange(false);
        },
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: this,
      );
}