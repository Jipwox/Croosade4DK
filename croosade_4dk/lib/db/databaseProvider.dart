
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider{

  Future<Database> get database => getDatabase();

  Future<Database> getDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'crusadeDB.db'),
      version: 1,
      onCreate: (Database database, int version) async{
        print("creating database");
        await database.execute(
          "CREATE TABLE CRUSADE_FORCE ("
              "ID INTEGER PRIMARY KEY,"
              "NAME TEXT,"
              "FACTION TEXT,"
              "BATTLE_TALLY INTEGER,"
              "BATTLES_WON INTEGER,"
              "REQUISITION_POINTS,"
              "SUPPLY_LIMIT,"
              "SUPPLY_USED"
              ");"
        );
      }
    );
  }
}