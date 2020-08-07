import 'dart:async';
import '../db/databaseProvider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class CrusadeForceModel {

  int id;
  String name;
  String faction;
  int battleTally;
  int battlesWon;
  int requisitionPoints;
  int supplyLimit;
  int supplyUsed;

  CrusadeForceModel(String name, String faction) {
    this.name = name;
    this.faction = faction;
    this.battleTally = 0;
    this.battlesWon = 0;
    this.requisitionPoints = 5;
    this.supplyLimit = 50;
    this.supplyUsed = 0;
  }

  Map<String, dynamic> toMap(){
    return{
      'ID' : id,
      'NAME' : name,
      'FACTION' : faction,
      'BATTLE_TALLY' : battleTally,
      'BATTLES_WON' : battlesWon,
      'REQUISITION_POINTS' : requisitionPoints,
      'SUPPLY_LIMIT' : supplyLimit,
      'SUPPLY_USED' : supplyUsed
    };
  }

  Future<void> insertCrusaderForceModel(CrusadeForceModel crusadeForceModel) async{
    final Database db = database
  }
}

