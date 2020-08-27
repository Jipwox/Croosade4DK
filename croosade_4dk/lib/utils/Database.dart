
import 'package:croosade_4dk/Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/Models/CrusadeForceModel.dart';
import 'package:croosade_4dk/Models/CrusadeBattleModel.dart';
import 'package:croosade_4dk/Models/CardBattleEntryModel.dart';
import 'package:flutter/cupertino.dart';
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
                  INFO TEXT,
                  IMAGE_PATH TEXT
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
                  BATTLES_SURVIVED INTEGER,
                  TOTAL_DESTROYED INTEGER,
                  TOTAL_DESTROYED_PSYCHIC INTEGER,
                  TOTAL_DESTROYED_RANGED INTEGER,
                  TOTAL_DESTROYED_MELEE INTEGER,
                  INFO TEXT,
                  TIMES_MARKED_FOR_GREATNESS INTEGER,
                  IMAGE_PATH TEXT,
                  FOREIGN KEY(CRUSADE_FORCE_ID) REFERENCES CRUSADE_FORCE(ID)
                  )
          ''');
          await database.execute('''
              CREATE TABLE CRUSADE_BATTLE (
                  ID INTEGER PRIMARY KEY,
                  CRUSADE_ID INTEGER,
                  NAME TEXT,
                  OPPOSING_FORCE_NAME TEXT,
                  BATTLE_UNITS TEXT,
                  INFO TEXT,
                  VICTORIOUS INT,
                  IMAGE_PATH TEXT,
                  DATE TEXT,
                  FOREIGN KEY(CRUSADE_ID) REFERENCES CRUSADE_FORCE(ID)
                  )
          ''');
          await database.execute('''
              CREATE TABLE CARD_BATTLE_ENTRY (
                  ID INTEGER PRIMARY KEY,
                  CARD_ID INTEGER,
                  BATTLE_ID INTEGER,
                  AGENDA_1_TALLY INTEGER,
                  AGENDA_2_TALLY INTEGER,
                  AGENDA_3_TALLY INTEGER,
                  TOTAL_DESTROYED INTEGER,
                  TOTAL_DESTROYED_PSYCHIC INTEGER,
                  TOTAL_DESTROYED_RANGED INTEGER,
                  TOTAL_DESTROYED_MELEE INTEGER,
                  NOTABLE_EVENTS TEXT,
                  IMAGE_PATH TEXT,
                  FOREIGN KEY(CARD_ID) REFERENCES CRUSADE_CARD(ID),
                  FOREIGN KEY(BATTLE_ID) REFERENCES CRUSADE_BATTLE(ID)
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

    var crusadeForces = await db.rawQuery(
        'SELECT * FROM CRUSADE_FORCE'
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

  Future<void> deleteCrusadeForceModel(int forceId) async{
    final db = await database;
    await db.rawDelete('DELETE FROM CRUSADE_FORCE WHERE ID = ?', [forceId]);
  }

  Future<void> updateCrusadeForceModel(CrusadeForceModel forceModel) async {
    final db = await database;
    await db.update('CRUSADE_FORCE', forceModel.toMap(),
        where: 'CRUSADE_FORCE.ID = ?',
        whereArgs: [forceModel.id]
    );
  }
  
  Future<void> updateCrusadeForceSupplyUsed(int id) async{
    final db = await database;
    var result = await db.rawQuery('select SUM(POWER_RATING) from CRUSADE_CARD where CRUSADE_FORCE_ID = ?',
    [id.toString()]);
    int supplyUsed = result[0]["SUM(POWER_RATING)"];
    if(supplyUsed == null) supplyUsed = 0;
    await db.rawUpdate('UPDATE CRUSADE_FORCE SET SUPPLY_USED = ? WHERE ID = ?',
    [supplyUsed, id]);
  }

  Future<void> incrementCrusadeForceBattleTally(int forceId, int incrementValue)  async{
    final db = await database;
    await db.rawUpdate('UPDATE CRUSADE_FORCE SET BATTLE_TALLY = BATTLE_TALLY + ? WHERE ID = ?', [incrementValue, forceId]);
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

  Future<void> deleteCrusadeCardModel(int cardId, int forceId) async{
    final db = await database;
    await db.rawDelete('DELETE FROM CRUSADE_CARD WHERE ID = ?', [cardId]);

    await updateCrusadeForceSupplyUsed(forceId);
  }

  Future<void> updateCrusadeCardModel(CrusadeCardModel cardModel) async {
    final db = await database;
    await db.update('CRUSADE_CARD', cardModel.toMap(),
        where: 'CRUSADE_CARD.ID = ?',
        whereArgs: [cardModel.id]
    );
  }
  
  Future<void> incrementCrusadeCardModelBattlesPlayed(int cardId, int incrementValue)  async{
    final db = await database;
    await db.rawUpdate('UPDATE CRUSADE_CARD SET BATTLES_PLAYED = BATTLES_PLAYED + ? WHERE ID = ?', [incrementValue, cardId]);
    await db.rawUpdate('UPDATE CRUSADE_CARD SET EXPERIENCE_POINTS = EXPERIENCE_POINTS + ? WHERE ID = ?', [incrementValue, cardId]);
  }

  // CRUSADE BATTLE METHODS

  Future<CrusadeBattleModel> insertCrusadeBattleModel (CrusadeBattleModel crusadeBattleModel) async{
    final db = await database;

    crusadeBattleModel.id = await db.insert('CRUSADE_BATTLE', crusadeBattleModel.toMap());

    return crusadeBattleModel;
  }

  Future<CrusadeBattleModel> getCrusadeBattle(int id) async {
    final db = await database;

    CrusadeBattleModel crusadeBattleModel;

    var result = await db.rawQuery(
        'Select * from CRUSADE_BATTLE where CRUSADE_BATTLE.id = ?',
        [id.toString()]
    );

    for(var row in result){
      crusadeBattleModel = CrusadeBattleModel.fromMap(row);
    }

    return crusadeBattleModel;
  }

  Future<List<CrusadeBattleModel>> getCrusadeBattles(int forceId) async {
    final db = await database;

    var crusadeBattles = await db.rawQuery(
        'SELECT * FROM CRUSADE_BATTLE WHERE CRUSADE_ID = ?',
        [forceId]
    );

    List<CrusadeBattleModel> battleModelList = List<CrusadeBattleModel>();

    crusadeBattles.forEach((currentBattle) {
      CrusadeBattleModel crusadeBattleModel = CrusadeBattleModel.fromMap(currentBattle);
      battleModelList.add(crusadeBattleModel);
    });

    return battleModelList;
  }

  Future<void> deleteCrusadeBattleModels(int id) async{
    final db = await database;
    await db.rawDelete('DELETE * FROM CRUSADE_BATTLE WHERE CRUSADE_ID = ?',
        [id]);
  }

  Future<void> deleteCrusadeBattleModel(int battleId) async{
    final db = await database;
    await db.rawDelete('DELETE FROM CRUSADE_BATTLE WHERE ID = ?', [battleId]);

  }

  Future<void> updateCrusadeBattleModel(CrusadeBattleModel battleModel) async {
    final db = await database;
    await db.update('CRUSADE_BATTLE', battleModel.toMap(),
        where: 'CRUSADE_BATTLE.ID = ?',
        whereArgs: [battleModel.id]
    );
  }

// CRUSADE CARD BATTLE ENTRY METHODS

  Future<CardBattleEntryModel> insertCardBattleEntryModel (CardBattleEntryModel cardBattleEntryModel) async{
    final db = await database;

    cardBattleEntryModel.id = await db.insert('CARD_BATTLE_ENTRY', cardBattleEntryModel.toMap());

    return cardBattleEntryModel;
  }

  Future<CardBattleEntryModel> getCardBattleEntryModel(int id) async {
    final db = await database;

    CardBattleEntryModel cardBattleEntryModel;

    var result = await db.rawQuery(
        'Select * from CARD_BATTLE_ENTRY where ID = ?',
        [id.toString()]
    );

    for(var row in result){
      cardBattleEntryModel = CardBattleEntryModel.fromMap(row);
    }

    return cardBattleEntryModel;
  }

  Future<List<CardBattleEntryModel>> getCardBattleEntryModels(int battleId) async {
    final db = await database;

    var cardBattleEntries = await db.rawQuery(
        'SELECT * FROM CARD_BATTLE_ENTRY WHERE BATTLE_ID = ?',
        [battleId]
    );

    List<CardBattleEntryModel> cardBattleEntryList = List<CardBattleEntryModel>();

    cardBattleEntries.forEach((entry) {
      CardBattleEntryModel cardBattleEntryModel = CardBattleEntryModel.fromMap(entry);
      cardBattleEntryList.add(cardBattleEntryModel);
    });

    return cardBattleEntryList;
  }

  Future<void> deleteCardBattleEntryModels(int id) async{
    final db = await database;
    await db.rawDelete('DELETE * FROM CARD_BATTLE_ENTRY WHERE BATTLE_ID = ?',
        [id]);
  }

  Future<void> deleteCardBattleEntryModel(int id) async{
    final db = await database;
    await db.rawDelete('DELETE FROM CARD_BATTLE_ENTRY WHERE ID = ?', [id]);

  }

  Future<void> updateCardBattleEntryModel(CardBattleEntryModel entryModel) async {
    final db = await database;
    await db.update('CARD_BATTLE_ENTRY', entryModel.toMap(),
        where: 'ID = ?',
        whereArgs: [entryModel.id]
    );
  }

}