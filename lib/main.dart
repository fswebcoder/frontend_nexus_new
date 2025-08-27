import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_nexus/core/utils/index.dart';
import 'package:frontend_nexus/entry_point/application/config/from.environment.dart';
import 'package:frontend_nexus/entry_point/data_source/database/configuration_db_source_adapter.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'entry_point/application/application_nexus.dart';
import 'entry_point/application/config/app_compilation_mode.dart';
import 'entry_point/application/config/app_setings.dart';
import 'entry_point/application/config/application.dart';
import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  tz.initializeTimeZones();

  await configureInjection('main');

  final connectivityService = getIt<GlobalConnectivityService>();
  await GlobalConnectivityService.initialize(connectivityService);

  final configurationDbSourceAdapter = ConfigurationDbSourceAdapter();
  
  try {
    final savedDarkMode = await configurationDbSourceAdapter.getDarkMode();
    final darkMode = savedDarkMode ?? false;
    SingletonSharedPreferencesImp().darkMode = darkMode;
  } catch (e) {
    SingletonSharedPreferencesImp().darkMode = false;
  }

  LicenseRegistry.addLicense(() async* {
    try {
      final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    } catch (e) {
      debugPrint('Error loading license: $e');
    }
  });

  final appSettings = AppSettings(
    baseUrl: ConfigDefine.apiBase, 
    mode: AppCompilationMode.main
  );
  Application().appSettings = appSettings;

  runApp(const ApplicationNexus());
}