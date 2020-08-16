import 'package:croosade_4dk/Widgets/CardBattlesPlayedRow.dart';
import 'package:croosade_4dk/Widgets/CardMeleeRow.dart';
import 'package:croosade_4dk/Widgets/CardPowerRatingRow.dart';
import 'package:croosade_4dk/Widgets/CardPsychicRow.dart';
import 'package:croosade_4dk/Widgets/CardRangedRow.dart';

import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/Widgets/CardExpRow.dart';

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
  TextEditingController cardTotalDestroyedController = new TextEditingController();
  TextEditingController cardInfoController = new TextEditingController();

  CardPowerRatingRow powerRatingRow;
  CardExpRow expRow;
  CardBattlesPlayedRow battlesPlayedRow;
  CardPsychicRow psychicRow;
  CardRangedRow rangedRow;
  CardMeleeRow meleeRow;



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
    cardTotalDestroyedController.text = cardModel.totalDestroyed.toString();
    cardInfoController.text = cardModel.info;

    powerRatingRow = CardPowerRatingRow(cardModel: cardModel);
    expRow = CardExpRow(cardModel: cardModel);
    battlesPlayedRow = CardBattlesPlayedRow(cardModel: cardModel);
    psychicRow = CardPsychicRow(cardModel: cardModel);
    rangedRow = CardRangedRow(cardModel: cardModel);
    meleeRow = CardMeleeRow(cardModel: cardModel);


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
    cardModel.totalDestroyed = int.parse(cardTotalDestroyedController.text);
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
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 20.0),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Name"),
                    SizedBox(width: 100,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardNameController,
                      ),
                    ),
                  ]
              ),
              powerRatingRow,
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Battlefield Role"),
                    SizedBox(width: 45,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardBattleFieldRoleController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Unit Type"),
                    SizedBox(width: 80,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardUnitTypeController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Equipment"),
                    SizedBox(width: 72,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardEquipmentController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Psychic Powers"),
                    SizedBox(width: 39,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardPsychicPowersController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Warlord Traits"),
                    SizedBox(width: 50,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardWarlordTraitsController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Relics"),
                    SizedBox(width: 101,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardRelicsController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Other Upgrades"),
                    SizedBox(width: 41,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardOtherUpgradesController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Battle Honors"),
                    SizedBox(width: 41,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardBattleHonorsController,
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Battle Scars"),
                    SizedBox(width: 41,),
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                        controller: cardBattleScarsController,
                      ),
                    ),
                  ]
              ),
              expRow,
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Crusade Points"),
                    SizedBox(width: 95,),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Text(cardModel.crusadePoints.toString()),
                    )
                  ]
              ),
              battlesPlayedRow,
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                    Text("Total Enemies Destroyed"),
                    SizedBox(width: 95,),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Text(cardModel.totalDestroyed.toString()),
                    )
                  ]
              ),
              psychicRow,
              rangedRow,
              meleeRow,
            ],
          ),
        );// This trailing comma makes auto-formatting nicer fo
      },
    );
  }

}