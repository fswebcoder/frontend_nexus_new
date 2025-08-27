// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:frontend_nexus/core/utils/index.dart' as _i806;
import 'package:frontend_nexus/data/db_sources/configurations/configuration_db_source.dart'
    as _i581;
import 'package:frontend_nexus/entry_point/data_source/database/configuration_db_source_adapter.dart'
    as _i435;
import 'package:frontend_nexus/injector_module.dart' as _i6;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectorModule = _$InjectorModule();
    gh.lazySingleton<_i806.SingletonSharedPreferences>(
        () => injectorModule.singletonSharedPreferences);
    gh.factory<String>(
      () => injectorModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i581.ConfigurationDbSource>(
        () => _i435.ConfigurationDbSourceAdapter());
    return this;
  }
}

class _$InjectorModule extends _i6.InjectorModule {}
