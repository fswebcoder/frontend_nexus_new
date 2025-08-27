import 'package:flutter/material.dart';

mixin FocusChangeMixin {
  void fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus == null) {
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      currentFocus.unfocus();
    }

    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
