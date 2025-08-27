import 'package:flutter/material.dart';
import 'package:frontend_nexus/entry_point/application/config/from.environment.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'entry_point/application/application_nexus.dart';
import 'entry_point/application/config/app_compilation_mode.dart';
import 'entry_point/application/config/app_setings.dart';
import 'entry_point/application/config/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  var appSettings =
      AppSettings(baseUrl: ConfigDefine.apiBase, mode: AppCompilationMode.main);
  Application().appSettings = appSettings;
  runApp(const ApplicationNexus());
}
