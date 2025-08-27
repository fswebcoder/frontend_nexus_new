import 'package:flutter/material.dart';

class InheritedCustomWidget extends InheritedWidget {
  final bool status;
  final Function() setStatus;
  const InheritedCustomWidget({
    super.key,
    required super.child,
    required this.setStatus,
    required this.status,
  });

  static InheritedCustomWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCustomWidget>()!;
  }

  @override
  bool updateShouldNotify(InheritedCustomWidget oldWidget) =>
      status != oldWidget.status;
} 