

class  CrusadeBattleModel {

  int id;
  int name;
  String opposingForceName;
  String battleUnits;
  String info;
  int victorious;
  String imagePath;

  CrusadeBattleModel(int name, String opposingForceName, String battleUnits, String info, bool victorious){
    this.name = name;
    this.opposingForceName = opposingForceName;
    this.battleUnits = battleUnits;
    this.info = "";
    this.victorious = 0;
    this.imagePath = "";
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'ID' : id,
      'NAME' : name,
      'OPPOSING_FORCE_NAME' : opposingForceName,
      'BATTLE_UNITS' : battleUnits,
      'INFO' : info,
      'VICTORIOUS' : victorious,
      'IMAGE_PATH' : imagePath,
    };

    if(id != null){
      map['ID'] = id;
    }

    return map;
  }

  CrusadeBattleModel.fromMap(Map<String, dynamic> map){
    id = map['ID'];
    name = map['NAME'];
    opposingForceName = map['OPPOSING_FORCE_NAME'];
    battleUnits = map['BATTLE_UNITS'];
    info = map['INFO'];
    victorious = map['VICTORIOUS'];
    imagePath = map['IMAGE_PATH'];
  }


}
