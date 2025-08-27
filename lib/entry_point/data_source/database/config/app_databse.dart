import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static AppDatabase? _singleton;
  Database? _db;

  factory AppDatabase() {
    _singleton ??= AppDatabase._();
    return _singleton!;
  }

  AppDatabase._();

  Future<Database> _setupDataBase(String dbName) async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    var dbPath = '${appDocDirectory.path}/$dbName.db';
    var dbFactory = databaseFactoryIo;
    return dbFactory.openDatabase(dbPath);
  }

  Future<Database> get database async {
    _db ??= await _setupDataBase('nexus_db');
    return _db as Database;
  }

  Future deleteDatabase() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    await databaseFactoryIo
        .deleteDatabase('${appDocDirectory.path}/cotrafa_db.db');
    _db = null;
  }
}
