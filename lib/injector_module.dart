import 'package:frontend_nexus/entry_point/application/index.dart';
import 'package:injectable/injectable.dart';

import 'core/utils/index.dart';

@module
abstract class InjectorModule {
  @Named("baseUrl")
  String get baseUrl => ConfigDefine.apiBase;

  @lazySingleton
  SingletonSharedPreferences get singletonSharedPreferences =>
      SingletonSharedPreferencesImp();
}
