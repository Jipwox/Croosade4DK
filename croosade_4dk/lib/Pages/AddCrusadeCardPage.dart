import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../Models/CrusadeCardModel.dart';
import '../utils/Database.dart';

class AddCrusadeCardPage extends StatefulWidget {

  final String title = "New Crusade Card";
  final int crusadeforceId;

  AddCrusadeCardPage({@required this.crusadeforceId});

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
  TextEditingController cardInfoController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
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
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Power Rating"),
                SizedBox(width: 55,),
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
                Text("Battlefield Role"),
                SizedBox(width: 45,),
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
                Text("Unit Type"),
                SizedBox(width: 80,),
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
                Text("Equipment"),
                SizedBox(width: 72,),
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
                Text("Psychic Powers"),
                SizedBox(width: 39,),
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
                Text("Warlord Traits"),
                SizedBox(width: 50,),
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
                Text("Relics"),
                SizedBox(width: 101,),
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
                Text("Other Upgrades"),
                SizedBox(width: 41,),
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
                SizedBox(width: 56,),
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
          RaisedButton(
            child: Text("Save"),
            onPressed: () => print("pressed save"),
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}