import 'package:flutter/cupertino.dart';

class CardBattleEntryModel{
  int id;
  int cardId;
  int battleId;
  int agenda1Tally;
  int agenda2Tally;
  int agenda3Tally;
  int totalDestroyed;
  int totalDestroyedPsychic;
  int totalDestroyedRanged;
  int totalDestroyedMelee;
  String notableEvents;
  String imagePath;

  CardBattleEntryModel(int cardId, int battleId){
    this.cardId = cardId;
    this.battleId = battleId;
    agenda1Tally = 0;
    agenda2Tally = 0;
    agenda3Tally = 0;
    totalDestroyed = 0;
    totalDestroyedPsychic = 0;
    totalDestroyedRanged = 0;
    totalDestroyedMelee = 0;
    notableEvents = "";
    this.imagePath = "";
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'ID' : id,
      'CARD_ID' : cardId,
      'BATTLE_ID' : battleId,
      'AGENDA_1_TALLY' : agenda1Tally,
      'AGENDA_2_TALLY' : agenda2Tally,
      'AGENDA_3_TALLY' : agenda3Tally,
      'TOTAL_DESTROYED' : totalDestroyed,
      'TOTAL_DESTROYED_PSYCHIC' : totalDestroyedPsychic,
      'TOTAL_DESTROYED_RANGED' : totalDestroyedRanged,
      'TOTAL_DESTROYED_MELEE' : totalDestroyedMelee,
      'NOTABLE_EVENTS' : notableEvents,
      'IMAGE_PATH' : imagePath,
    };

    if(id != null){
      map['ID'] = id;
    }

    return map;
  }

  CardBattleEntryModel.fromMap(Map<String, dynamic> map){
    id = map['ID'];
    cardId = map['CARD_ID'];
    battleId = map['BATTLE_ID'];
    agenda1Tally = map['AGENDA_1_TALLY'];
    agenda2Tally = map['AGENDA_2_TALLY'];
    agenda3Tally = map['AGENDA_3_TALLY'];
    totalDestroyed = map['TOTAL_DESTROYED'];
    totalDestroyedPsychic = map['TOTAL_DESTROYED_PSYCHIC'];
    totalDestroyedRanged = map['TOTAL_DESTROYED_RANGED'];
    totalDestroyedMelee = map['TOTAL_DESTROYED_MELEE'];
    notableEvents = map['NOTABLE_EVENTS'];
    imagePath = map['IMAGE_PATH'];
  }

}