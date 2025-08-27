import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/config/app_routes.dart';

mixin RedirectToLoginMixin {
  void navegarLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute,
        ModalRoute.withName(AppRoutes.initialRoute));
  }
}
