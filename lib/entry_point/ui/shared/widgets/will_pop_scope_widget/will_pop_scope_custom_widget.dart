import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
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
    // En web, usar PopScope. En móvil, detectar Android
    final bool usePopScope = kIsWeb || (!kIsWeb && Platform.isAndroid);
    
    return usePopScope
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
