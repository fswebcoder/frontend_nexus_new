import 'package:frontend_nexus/data/db_sources/configurations/configuration_db_source.dart'
    show ConfigurationDbSource;
import 'package:frontend_nexus/entry_point/data_source/database/base_db_source.dart'
    show BaseDBSource;
import 'package:sembast/sembast.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ConfigurationDbSource)
class ConfigurationDbSourceAdapter extends BaseDBSource
    implements ConfigurationDbSource {
  final String _storeModoOscuro = 'darkMode';

  @override
  Future<void> saveDarkMode(bool? darkMode) async {
    await storeRef.record(_storeModoOscuro).put(await db, darkMode);
  }

  @override
  Future<bool?> getDarkMode() async {
    final value = await storeRef.record(_storeModoOscuro).get(await db);
    return value as bool?;
  }
}
