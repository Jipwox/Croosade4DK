import 'dart:convert';

class CrusadeCardModel{

  int id;
  int crusadeForceId;
  String name;
  String rank;
  String battleHonors;
  String battleScars;
  int powerRating;
  int experiencePoints;
  int crusadePoints;
  String battlefieldRole;
  String unitType;
  String equipment;
  String psychicPowers;
  String warlordTraits;
  String relics;
  String otherUpgrades;
  int battlesPlayed;
  int totalDestroyed;
  int totalDestroyedPsychic;
  int totalDestroyedRanged;
  int totalDestroyedMelee;
  String info = "";

  CrusadeCardModel(int crusadeForceId, String name, int powerRating, String battleFieldRole,
                    String unitType, String equipment, String psychicPowers, String warlordTraits,
                    String relics, String otherUpgrades) {
    this.name = name;
    this.crusadeForceId = crusadeForceId;
    this.rank = "Battle-ready";
    this.battleHonors = "";
    this.battleScars = "";
    this.powerRating = powerRating;
    this.experiencePoints = 0;
    this.crusadePoints = 0;
    this.battlefieldRole = battleFieldRole;
    this.unitType = unitType;
    this.equipment = equipment;
    this.psychicPowers = psychicPowers;
    this.warlordTraits = warlordTraits;
    this.relics = relics;
    this.otherUpgrades = otherUpgrades;
    this.battlesPlayed = 0;
    this.totalDestroyed = 0;
    this.totalDestroyedPsychic = 0;
    this.totalDestroyedRanged = 0;
    this.totalDestroyedMelee = 0;
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'ID' : id,
      'CRUSADE_FORCE_ID' : crusadeForceId,
      'NAME' : name,
      'RANK' : rank,
      'BATTLE_HONORS' : battleHonors,
      'BATTLE_SCARS' : battleScars,
      'POWER_RATING' : powerRating,
      'EXPERIENCE_POINTS' : experiencePoints,
      'CRUSADE_POINTS' : crusadePoints,
      'BATTLEFIELD_ROLE' : battlefieldRole,
      'UNIT_TYPE' : unitType,
      'EQUIPMENT' : equipment,
      'PSYCHIC_POWERS' : psychicPowers,
      'WARLORD_TRAITS' : warlordTraits,
      'RELICS' : relics,
      'OTHER_UPGRADES' : otherUpgrades,
      'BATTLES_PLAYED' : battlesPlayed,
      'TOTAL_DESTROYED' : totalDestroyed,
      'TOTAL_DESTROYED_PSYCHIC' : totalDestroyedPsychic,
      'TOTAL_DESTROYED_RANGED' : totalDestroyedRanged,
      'TOTAL_DESTROYED_MELEE' : totalDestroyedMelee,
      'INFO' : info,

    };

    if(id != null){
      map['ID'] = id;
    }

    return map;
  }

  CrusadeCardModel.fromMap(Map<String, dynamic> map){
    id = map['ID'];
    crusadeForceId = map['CRUSADE_FORCE_ID'];
    name = map['NAME'];
    rank = map['RANK'];
    battleHonors = map['BATTLE_HONORS'];
    battleScars = map['BATTLE_SCARS'];
    powerRating = map['POWER_RATING'];
    experiencePoints = map['EXPERIENCE_POINTS'];
    crusadePoints = map['CRUSADE_POINTS'];
    battlefieldRole = map['BATTLEFIELD_ROLE'];
    unitType = map['UNIT_TYPE'];
    equipment = map['EQUIPMENT'];
    psychicPowers = map['PSYCHIC_POWERS'];
    warlordTraits = map['WARLORD_TRAITS'];
    relics = map['RELICS'];
    otherUpgrades = map['OTHER_UPGRADES'];
    battlesPlayed = map['BATTLES_PLAYED'];
    totalDestroyed = map['TOTAL_DESTROYED'];
    totalDestroyedPsychic = map['TOTAL_DESTROYED_PSYCHIC'];
    totalDestroyedRanged = map['TOTAL_DESTROYED_RANGED'];
    totalDestroyedMelee = map['TOTAL_DESTROYED_MELEE'];
    info = map['INFO'];
  }

  //BattleHonors
  List<String> getBattleHonors(){
    return json.decode(battleHonors);
  }

  void addBattleHonor(String battleHonor){
    List<String> battleHonorList = json.decode(battleHonors);
    battleHonorList.add(battleHonor);
    battleHonors = json.encode(battleHonorList);
  }

  void removeBattleHonor(String battleHonor){
    List<String> battleHonorList = json.decode(battleHonors);
    battleHonorList.removeWhere((element) => element == battleHonor);
    battleHonors = json.encode(battleHonorList);
  }

  //BattleScars
  List<String> getBattleScars(){
    return json.decode(battleScars);
  }

  void addBattleScar(String battleScar){
    List<String> battleScarList = json.decode(battleScars);
    battleScarList.add(battleScar);
    battleScars = json.encode(battleScarList);
  }

  void removeBattleScar(String battleScar){
    List<String> battleScarList = json.decode(battleScar);
    battleScarList.removeWhere((element) => element == battleScar);
    battleScars = json.encode(battleScarList);
  }


}