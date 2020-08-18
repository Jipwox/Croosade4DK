
import 'package:croosade_4dk/Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/Models/CrusadeForceModel.dart';
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
        version: 2,
        onCreate: (Database database, int version) async{
          await database.execute('''
              CREATE TABLE CRUSADE_FORCE (
                  ID INTEGER PRIMARY KEY,
                  NAME TEXT,
                  FACTION TEXT,
                  BATTLE_TALLY INTEGER,
                  BATTLES_WON INTEGER,
                  REQUISITION_POINTS INTEGER,
                  SUPPLY_LIMIT INTEGER,
                  SUPPLY_USED INTEGER,
                  INFO TEXT
                  )
          ''');
          await database.execute('''
              CREATE TABLE CRUSADE_CARD (
                  ID INTEGER PRIMARY KEY,
                  CRUSADE_FORCE_ID INTEGER,
                  NAME TEXT,
                  RANK TEXT,
                  BATTLE_HONORS TEXT,
                  BATTLE_SCARS TEXT,
                  POWER_RATING INTEGER,
                  EXPERIENCE_POINTS INTEGER,
                  CRUSADE_POINTS INTEGER,
                  BATTLEFIELD_ROLE TEXT,
                  UNIT_TYPE TEXT,
                  EQUIPMENT TEXT,
                  PSYCHIC_POWERS TEXT,
                  WARLORD_TRAITS TEXT,
                  RELICS TEXT,
                  OTHER_UPGRADES TEXT,
                  BATTLES_PLAYED INTEGER,
                  TOTAL_DESTROYED INTEGER,
                  TOTAL_DESTROYED_PSYCHIC INTEGER,
                  TOTAL_DESTROYED_RANGED INTEGER,
                  TOTAL_DESTROYED_MELEE INTEGER,
                  INFO TEXT,
                  TIMES_MARKED_FOR_GREATNESS INTEGER,
                  FOREIGN KEY(CRUSADE_FORCE_ID) REFERENCES CRUSADE_FORCE(ID)
                  )
          ''');
        }
    );
  }

  //CRUSADE FORCE MODEL METHODS

  Future<CrusadeForceModel> getCrusadeForce(int id) async {
    final db = await database;

    CrusadeForceModel crusadeForceModel;

    var result = await db.rawQuery(
      'Select * from CRUSADE_FORCE where CRUSADE_FORCE.id = ?',
      [id.toString()]
    );

    for(var row in result){
      crusadeForceModel = CrusadeForceModel.fromMap(row);
    }

    return crusadeForceModel;
  }

  Future<List<CrusadeForceModel>> getCrusadeForces() async {
    final db = await database;

    var crusadeForces = await db.query(
      'CRUSADE_FORCE',
        columns: ['ID', 'NAME', 'FACTION', 'BATTLE_TALLY', 'BATTLES_WON',
                'REQUISITION_POINTS', 'SUPPLY_LIMIT', 'SUPPLY_USED', 'INFO']
    );

    List<CrusadeForceModel> forceModelList = List<CrusadeForceModel>();

    crusadeForces.forEach((currentForce) {
      CrusadeForceModel crusadeForceModel = CrusadeForceModel.fromMap(currentForce);
      forceModelList.add(crusadeForceModel);
    });

    return forceModelList;
  }

  Future<CrusadeForceModel> insertCrusadeForceModel (CrusadeForceModel crusadeForceModel) async{
    final db = await database;

    crusadeForceModel.id = await db.insert('CRUSADE_FORCE', crusadeForceModel.toMap());

    return crusadeForceModel;
  }

  Future<void> deleteCrusadeForceModels() async{
    final db = await database;
    await db.delete('CRUSADE_CARD');
    await db.delete('CRUSADE_FORCE');
  }

  Future<void> updateCrusadeForceModel(CrusadeForceModel forceModel) async {
    final db = await database;
    await db.update('CRUSADE_FORCE', forceModel.toMap(),
        where: 'CRUSADE_FORCE.ID = ?',
        whereArgs: [forceModel.id]
    );
  }

  //CRUSADE CARD MODEL METHODS

  Future<CrusadeCardModel> insertCrusadeCardModel (CrusadeCardModel crusadeCardModel) async{
    final db = await database;

    crusadeCardModel.id = await db.insert('CRUSADE_CARD', crusadeCardModel.toMap());

    return crusadeCardModel;
  }

  Future<CrusadeCardModel> getCrusadeCard(int id) async {
    final db = await database;

    CrusadeCardModel crusadeCardModel;

    var result = await db.rawQuery(
        'Select * from CRUSADE_CARD where CRUSADE_CARD.id = ?',
        [id.toString()]
    );

    for(var row in result){
      crusadeCardModel = CrusadeCardModel.fromMap(row);
    }

    return crusadeCardModel;
  }

  Future<List<CrusadeCardModel>> getCrusadeCards(int forceId) async {
    final db = await database;

    var crusadeCards = await db.rawQuery(
        'SELECT * FROM CRUSADE_CARD WHERE CRUSADE_CARD.CRUSADE_FORCE_ID = ?',
        [forceId]
    );

    List<CrusadeCardModel> cardModelList = List<CrusadeCardModel>();

    crusadeCards.forEach((currentCard) {
      CrusadeCardModel crusadeCardModel = CrusadeCardModel.fromMap(currentCard);
      cardModelList.add(crusadeCardModel);
    });

    return cardModelList;
  }

  Future<void> deleteCrusadeCardModels(int id) async{
    final db = await database;
    await db.rawDelete('DELETE * FROM CRUSADE_CARD WHERE CRUSADE_CARD.CRUSADE_FORCE_ID = ?',
                        [id]);
  }

  Future<void> updateCrusadeCardModel(CrusadeCardModel cardModel) async {
    final db = await database;
    await db.update('CRUSADE_CARD', cardModel.toMap(),
        where: 'CRUSADE_CARD.ID = ?',
        whereArgs: [cardModel.id]
    );
  }
}