import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class AppDatabase {
  static AppDatabase? _singleton;
  Database? _db;

  factory AppDatabase() {
    _singleton ??= AppDatabase._();
    return _singleton!;
  }

  AppDatabase._();

  Future<Database> _setupDataBase(String dbName) async {
    if (kIsWeb) {
      // Para web, usar sembast_web directamente
      var dbFactory = databaseFactoryWeb;
      return dbFactory.openDatabase('$dbName.db');
    } else {
      // Para plataformas nativas, usar path_provider y sembast_io
      var appDocDirectory = await getApplicationDocumentsDirectory();
      var dbPath = '${appDocDirectory.path}/$dbName.db';
      var dbFactory = databaseFactoryIo;
      return dbFactory.openDatabase(dbPath);
    }
  }

  Future<Database> get database async {
    _db ??= await _setupDataBase('nexus_db');
    return _db as Database;
  }

  Future deleteDatabase() async {
    if (kIsWeb) {
      // Para web, usar sembast_web
      await databaseFactoryWeb.deleteDatabase('nexus_db.db');
    } else {
      // Para plataformas nativas
      var appDocDirectory = await getApplicationDocumentsDirectory();
      await databaseFactoryIo
          .deleteDatabase('${appDocDirectory.path}/nexus_db.db');
    }
    _db = null;
  }
}
