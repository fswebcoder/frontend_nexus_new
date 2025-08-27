import 'package:frontend_nexus/entry_point/data_source/database/config/app_databse.dart';
import 'package:sembast/sembast.dart';

class BaseDBSource {
  Future<Database> get db => AppDatabase().database;
  StoreRef get storeRef => StoreRef.main();

  BaseDBSource() {
    AppDatabase().database;
  }
}
