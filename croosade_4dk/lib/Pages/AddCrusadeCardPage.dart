import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import '../utils/Database.dart';

class AddCrusadeCardPage extends StatefulWidget {

  final String title = "New Crusade Card";
  final int crusadeForceId;

  AddCrusadeCardPage({@required this.crusadeForceId});

  @override
  _AddCrusadeCardState createState() => _AddCrusadeCardState();
}

class _AddCrusadeCardState extends State<AddCrusadeCardPage> {

  TextEditingController cardNameController = new TextEditingController();
  TextEditingController cardPowerRatingController = new TextEditingController();
  TextEditingController cardBattleFieldRoleController = new TextEditingController();
  TextEditingController cardUnitTypeController = new TextEditingController();
  TextEditingController cardEquipmentController = new TextEditingController();
  TextEditingController cardPsychicPowersController = new TextEditingController();
  TextEditingController cardWarlordTraitsController = new TextEditingController();
  TextEditingController cardRelicsController = new TextEditingController();
  TextEditingController cardOtherUpgradesController = new TextEditingController();

  MediaQueryData queryData;

  void writeToDB(String cardName, String cardPowerRating, String cardBattleFieldRole,
                 String cardUnitType, String cardEquipment, String cardPsychicPowers, String cardWarlordTraits,
                 String cardRelics, String cardOtherUpgrades, String cardInfo) async {

    var crusadeCardModel = new CrusadeCardModel(widget.crusadeForceId, cardName,
        int.parse(cardPowerRating), cardBattleFieldRole, cardUnitType, cardEquipment, cardPsychicPowers,
        cardWarlordTraits, cardRelics, cardOtherUpgrades);


    var result = await DatabaseProvider.db.insertCrusadeCardModel(crusadeCardModel);
    DatabaseProvider.db.updateCrusadeForceSupplyUsed(widget.crusadeForceId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20.0),),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                  Text("Name"),
                  SizedBox(width: queryData.size.width/4.13,),
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
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                  Text("Power Rating"),
                  SizedBox(width: queryData.size.width/7.5,),
                  Container(
                    width: 250.0,
                    child: TextField(
                      decoration: InputDecoration(
                      ),
                      controller: cardPowerRatingController,
                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                  Text("Battlefield Role"),
                  SizedBox(width: queryData.size.width/9.2,),
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
                  SizedBox(width: queryData.size.width/5.2,),
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
                  SizedBox(width: queryData.size.width/5.7,),
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
                  SizedBox(width: queryData.size.width/10.4,),
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
                  SizedBox(width: queryData.size.width/8.1,),
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
                  SizedBox(width: queryData.size.width/4.1,),
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
                  SizedBox(width: queryData.size.width/10.2,),
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
            RaisedButton(
              child: Text("Save"),
              onPressed: () => {
                writeToDB(cardNameController.text, cardPowerRatingController.text,
                    cardBattleFieldRoleController.text, cardUnitTypeController.text,
                    cardEquipmentController.text, cardPsychicPowersController.text,
                    cardWarlordTraitsController.text, cardRelicsController.text,
                    cardOtherUpgradesController.text, cardOtherUpgradesController.text)
              },
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}