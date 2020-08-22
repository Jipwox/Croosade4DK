import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/Widgets/CardDetailScrollView.dart';

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
  TextEditingController cardExperiencePointsController = new TextEditingController();
  TextEditingController cardCrusadePointsController = new TextEditingController();
  TextEditingController cardBattleFieldRoleController = new TextEditingController();
  TextEditingController cardUnitTypeController = new TextEditingController();
  TextEditingController cardEquipmentController = new TextEditingController();
  TextEditingController cardPsychicPowersController = new TextEditingController();
  TextEditingController cardWarlordTraitsController = new TextEditingController();
  TextEditingController cardRelicsController = new TextEditingController();
  TextEditingController cardOtherUpgradesController = new TextEditingController();
  TextEditingController cardInfoController = new TextEditingController();


  CrusadeCardModel cardModel;

  Future<CrusadeCardModel> retrieveModel() async {
    cardModel = await DatabaseProvider.db.getCrusadeCard(widget.cardModel.id);

    cardNameController.text = cardModel.name;
    cardRankController.text = cardModel.rank;
    cardBattleHonorsController.text = cardModel.battleHonors;
    cardBattleScarsController.text = cardModel.battleScars;
    cardCrusadePointsController.text = cardModel.crusadePoints.toString();
    cardBattleFieldRoleController.text = cardModel.battlefieldRole;
    cardUnitTypeController.text = cardModel.unitType;
    cardEquipmentController.text = cardModel.equipment;
    cardPsychicPowersController.text = cardModel.psychicPowers;
    cardWarlordTraitsController.text = cardModel.warlordTraits;
    cardRelicsController.text = cardModel.relics;
    cardOtherUpgradesController.text = cardModel.otherUpgrades;
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
    cardModel.crusadePoints = int.parse(cardCrusadePointsController.text);
    cardModel.battlefieldRole = cardBattleFieldRoleController.text;
    cardModel.unitType = cardUnitTypeController.text;
    cardModel.equipment = cardEquipmentController.text;
    cardModel.psychicPowers = cardPsychicPowersController.text;
    cardModel.warlordTraits = cardWarlordTraitsController.text;
    cardModel.relics = cardRelicsController.text;
    cardModel.otherUpgrades = cardOtherUpgradesController.text;
    cardModel.info = cardInfoController.text;


    await DatabaseProvider.db.updateCrusadeCardModel(crusadeCardModel);
  }

  void refreshPage(){
    setState(() {
      retrieveModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
        return CardDetailScrollView(cardModel: cardModel, cardBattleFieldRoleController: cardBattleFieldRoleController,
                                    cardEquipmentController: cardEquipmentController, cardInfoController: cardInfoController,
                                    cardNameController: cardNameController, cardOtherUpgradesController: cardOtherUpgradesController,
                                    cardPsychicPowersController: cardPsychicPowersController, cardRelicsController: cardRelicsController,
                                    cardUnitTypeController: cardUnitTypeController, cardWarlordTraitsController: cardWarlordTraitsController,);
      },
    );
  }

}