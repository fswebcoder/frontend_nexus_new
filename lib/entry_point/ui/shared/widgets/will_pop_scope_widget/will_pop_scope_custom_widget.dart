import 'dart:io';

import 'package:flutter/material.dart';

class WillPopScopeCustomWidget extends StatelessWidget {
  final Widget child;
  final Function() callBack;
  const WillPopScopeCustomWidget({
    super.key,
    required this.child,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? PopScope(
            canPop: false,
            child: child,
            onPopInvokedWithResult: (bool didPop, Object? result) {
              if (didPop) {
                return;
              }
              callBack();
            },
          )
        : GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 20) {
                callBack();
              }
            },
            child: child,
          );
  }
}
