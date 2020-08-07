
import 'package:croosade_4dk/Models/CrusadeForceModel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
        join(dbPath, 'crusadeDB.db'),
        version: 1,
        onCreate: (Database database, int version) async{
          await database.execute('''
              CREATE TABLE CRUSADE_FORCE (
                  ID INTEGER PRIMARY KEY,
                  NAME TEXT,
                  FACTION TEXT,
                  BATTLE_TALLY INTEGER,
                  BATTLES_WON INTEGER,
                  REQUISITION_POINTS,
                  SUPPLY_LIMIT,
                  SUPPLY_USED
                  )
          ''');
        }
    );
  }

  Future<List<CrusadeForceModel>> getCrusadeForces() async {
    final db = await database;

    var crusadeForces = await db.query(
      'CRUSADE_FORCE',
        columns: ['ID', 'NAME', 'FACTION', 'BATTLE_TALLY', 'BATTLES_WON',
                'REQUISITION_POINTS', 'SUPPLY_LIMIT', 'SUPPLY_USED']
    );

    List<CrusadeForceModel> forceModelList = List<CrusadeForceModel>();

    crusadeForces.forEach((currentForce) {
      CrusadeForceModel crusadeForceModel = CrusadeForceModel.fromMap(currentForce);
      forceModelList.add(crusadeForceModel);
    });

    return forceModelList;
  }

  Future<CrusadeForceModel> insert (CrusadeForceModel crusadeForceModel) async{
    final db = await database;

    crusadeForceModel.id = await db.insert('CRUSADE_FORCE', crusadeForceModel.toMap());

    return crusadeForceModel;
  }

  Future<void> deleteCrusadeForceModels() async{
    final db = await database;
    await db.delete('CRUSADE_FORCE');
  }

}