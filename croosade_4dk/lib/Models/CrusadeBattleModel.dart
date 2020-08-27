import 'dart:convert';

class  CrusadeBattleModel {

  int id;
  int crusadeId;
  String name;
  String opposingForceName;
  String battleUnits;
  String info;
  int victorious;
  String imagePath;
  String date;

  CrusadeBattleModel(String name, int crusadeId, String opposingForceName, String info, String date){
    this.name = name;
    this.crusadeId = crusadeId;
    this.opposingForceName = opposingForceName;
    this.battleUnits = "";
    this.info = "";
    this.victorious = 0;
    this.imagePath = "";
    this.date = date;
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'ID' : id,
      'CRUSADE_ID' : crusadeId,
      'NAME' : name,
      'OPPOSING_FORCE_NAME' : opposingForceName,
      'BATTLE_UNITS' : battleUnits,
      'INFO' : info,
      'VICTORIOUS' : victorious,
      'IMAGE_PATH' : imagePath,
      'DATE' : date
    };

    if(id != null){
      map['ID'] = id;
    }

    return map;
  }

  CrusadeBattleModel.fromMap(Map<String, dynamic> map){
    id = map['ID'];
    crusadeId = map['CRUSADE_ID'];
    name = map['NAME'];
    opposingForceName = map['OPPOSING_FORCE_NAME'];
    battleUnits = map['BATTLE_UNITS'];
    info = map['INFO'];
    victorious = map['VICTORIOUS'];
    imagePath = map['IMAGE_PATH'];
    date = map['DATE'];
  }

  //BattleUnits
  List<int> getBattleUnits(){
    try{
      return (jsonDecode(battleUnits) as List<dynamic>).cast<int>();
    }
    catch(e){
      battleUnits = json.encode(new List<int>());
      return (jsonDecode(battleUnits) as List<dynamic>).cast<int>();
    }
  }

  void addBattleUnit(int battleUnit){
    List<int> battleUnitList;
    try{
      battleUnitList = (jsonDecode(battleUnits) as List<dynamic>).cast<int>();
    }
    catch(e){
      battleUnits = json.encode(new List<int>());
      battleUnitList = (jsonDecode(battleUnits) as List<dynamic>).cast<int>();
    }

    battleUnitList.add(battleUnit);
    battleUnits = json.encode(battleUnitList);
  }

  void addBattleUnits(List<int> battleUnitsList){
    battleUnits = json.encode(battleUnitsList);
  }

  void removeBattleUnit(int battleUnit){
    List<int> battleUnitList = (jsonDecode(battleUnits) as List<dynamic>).cast<int>();
    battleUnitList.remove(battleUnit);
    battleUnits = json.encode(battleUnitList);
  }


}
