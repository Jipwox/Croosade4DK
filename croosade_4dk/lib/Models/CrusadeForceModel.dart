

class CrusadeForceModel {

  int id;
  String name;
  String faction;
  int battleTally;
  int battlesWon;
  int requisitionPoints;
  int supplyLimit;
  int supplyUsed;
  String info;

  CrusadeForceModel(String name, String faction) {
    this.name = name;
    this.faction = faction;
    this.battleTally = 0;
    this.battlesWon = 0;
    this.requisitionPoints = 5;
    this.supplyLimit = 50;
    this.supplyUsed = 0;
    this.info = "";
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'ID' : id,
      'NAME' : name,
      'FACTION' : faction,
      'BATTLE_TALLY' : battleTally,
      'BATTLES_WON' : battlesWon,
      'REQUISITION_POINTS' : requisitionPoints,
      'SUPPLY_LIMIT' : supplyLimit,
      'SUPPLY_USED' : supplyUsed,
      'INFO' : info
    };

    if(id != null){
      map['ID'] = id;
    }

    return map;
  }

  CrusadeForceModel.fromMap(Map<String, dynamic> map){
    id = map['ID'];
    name = map['NAME'];
    faction = map['FACTION'];
    battleTally = map['BATTLE_TALLY'];
    battlesWon = map['BATTLES_WON'];
    requisitionPoints = map['REQUISITION_POINTS'];
    supplyLimit = map['SUPPLY_LIMIT'];
    supplyUsed = map['SUPPLY_USED'];
    info = map['INFO'];

  }

}

