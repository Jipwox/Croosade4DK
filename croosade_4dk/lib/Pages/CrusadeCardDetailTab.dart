import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';

class CrusadeCardDetailTab extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CrusadeCardDetailTab({@required this.cardModel});

  @override
  _CrusadeCardDetailTabState createState() => _CrusadeCardDetailTabState();
}

class _CrusadeCardDetailTabState extends State<CrusadeCardDetailTab>{

  TextEditingController cardNameController = new TextEditingController();
  TextEditingController cardRankController = new TextEditingController();
  TextEditingController cardBattleHonorsController = new TextEditingController();
  TextEditingController cardBattleScarsController = new TextEditingController();
  TextEditingController cardPowerRatingController = new TextEditingController();
  TextEditingController cardExperiencePointsController = new TextEditingController();
  TextEditingController cardCrusadePointsController = new TextEditingController();
  TextEditingController cardBattleFieldRoleController = new TextEditingController();
  TextEditingController cardUnitTypeController = new TextEditingController();
  TextEditingController cardEquipmentController = new TextEditingController();
  TextEditingController cardPsychicPowersController = new TextEditingController();
  TextEditingController cardWarlordTraitsController = new TextEditingController();
  TextEditingController cardRelicsController = new TextEditingController();
  TextEditingController cardOtherUpgradesController = new TextEditingController();
  TextEditingController cardBattlesPlayedController = new TextEditingController();
  TextEditingController cardTotalDestroyedController = new TextEditingController();
  TextEditingController cardTotalDestroyedPsychicController = new TextEditingController();
  TextEditingController cardTotalDestroyedRangedController = new TextEditingController();
  TextEditingController cardTotalDestroyedMeleeController = new TextEditingController();
  TextEditingController cardInfoController = new TextEditingController();

  CrusadeCardModel cardModel;

  Future<CrusadeCardModel> retrieveModel() async {
    cardModel = await DatabaseProvider.db.getCrusadeCard(widget.cardModel.id);

    cardNameController.text = cardModel.name;
    cardRankController.text = cardModel.rank;
    cardBattleHonorsController.text = cardModel.battleHonors;
    cardBattleScarsController.text = cardModel.battleScars;
    cardPowerRatingController.text = cardModel.powerRating.toString();
    cardExperiencePointsController.text = cardModel.experiencePoints.toString();
    cardCrusadePointsController.text = cardModel.crusadePoints.toString();
    cardBattleFieldRoleController.text = cardModel.battlefieldRole;
    cardUnitTypeController.text = cardModel.unitType;
    cardEquipmentController.text = cardModel.equipment;
    cardPsychicPowersController.text = cardModel.psychicPowers;
    cardWarlordTraitsController.text = cardModel.warlordTraits;
    cardRelicsController.text = cardModel.relics;
    cardOtherUpgradesController.text = cardModel.otherUpgrades;
    cardBattlesPlayedController.text = cardModel.battlesPlayed.toString();
    cardTotalDestroyedController.text = cardModel.totalDestroyed.toString();
    cardTotalDestroyedPsychicController.text = cardModel.totalDestroyedPsychic.toString();
    cardTotalDestroyedRangedController.text = cardModel.totalDestroyedRanged.toString();
    cardTotalDestroyedMeleeController.text = cardModel.totalDestroyedMelee.toString();
    cardInfoController.text = cardModel.info;


    print("Inside retrieveModel()");
    print("forceModel ID = ${cardModel.id}");

    return cardModel;
  }

  @override
  void initState(){
    super.initState();
    retrieveModel();
  }

  void updateCardModel(CrusadeCardModel crusadeCardModel) async {

    cardModel.name = cardNameController.text;
    cardModel.rank = cardRankController.text;
    cardModel.battleHonors = cardBattleHonorsController.text;
    cardModel.battleScars = cardBattleScarsController.text;
    cardModel.powerRating = int.parse(cardPowerRatingController.text);
    cardModel.experiencePoints = int.parse(cardExperiencePointsController.text);
    cardModel.crusadePoints = int.parse(cardCrusadePointsController.text);
    cardModel.battlefieldRole = cardBattleFieldRoleController.text;
    cardModel.unitType = cardUnitTypeController.text;
    cardModel.equipment = cardEquipmentController.text;
    cardModel.psychicPowers = cardPsychicPowersController.text;
    cardModel.warlordTraits = cardWarlordTraitsController.text;
    cardModel.relics = cardRelicsController.text;
    cardModel.otherUpgrades = cardOtherUpgradesController.text;
    cardModel.battlesPlayed = int.parse(cardBattlesPlayedController.text);
    cardModel.totalDestroyed = int.parse(cardTotalDestroyedController.text);
    cardModel.totalDestroyedPsychic = int.parse(cardTotalDestroyedPsychicController.text);
    cardModel.totalDestroyedRanged = int.parse(cardTotalDestroyedRangedController.text);
    cardModel.totalDestroyedMelee = int.parse(cardTotalDestroyedMeleeController.text);
    cardModel.info = cardInfoController.text;


    await DatabaseProvider.db.updateCrusadeCardModel(crusadeCardModel);

    refreshPage();
    Navigator.pop(context);
  }

  void refreshPage(){
    setState(() {
      retrieveModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshPage();
    return FutureBuilder(
      future: retrieveModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
        return Text("card detail tab for ${cardModel.name}");
      },
    );
  }

}