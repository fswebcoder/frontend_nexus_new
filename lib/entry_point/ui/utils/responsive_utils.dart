import 'dart:developer';

import 'package:flutter/material.dart';

class Responsive {
  static double text(BuildContext context, {double ajuste = 1.5}) {
    try {
      final size = MediaQuery.of(context).size;
      if (size.width > 500) {
        return size.width / ajuste;
      } else {
        return size.width;
      }
    } catch (e) {
      log(e.toString());
      return 380;
    }
  }

  static Widget responsiveWidget(Widget? widget, BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 500) {
      return Transform.scale(
        scale: 0.7,
        child: widget ??
            SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.1,
            ),
      );
    } else {
      return widget ??
          SizedBox(
            height: size.height * 0.1,
            width: size.width * 0.1,
          );
    }
  }
}
