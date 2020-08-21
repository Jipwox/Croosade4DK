import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardDetailScrollView extends StatefulWidget {
  final CrusadeCardModel cardModel;
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

  CardDetailScrollView({@required this.cardModel, @required this.cardNameController, @required this.cardBattleFieldRoleController,
                        @required this.cardUnitTypeController, @required this.cardEquipmentController, @required this.cardPsychicPowersController,
                        @required this.cardWarlordTraitsController, @required this.cardRelicsController, @required this.cardOtherUpgradesController,
                        @required this.cardBattleHonorsController, @required this.cardBattleScarsController, @required this.cardInfoController});

  @override
  _CardDetailScrollViewState createState() => _CardDetailScrollViewState();

}

class _CardDetailScrollViewState extends State<CardDetailScrollView>{


  void updateRank (int exp){

    if(exp < 6){
      widget.cardModel.rank = "Battle-Ready";
    }
    else if (exp < 16){
      widget.cardModel.rank = "Blooded";
    }
    else if (exp < 31){
      widget.cardModel.rank = "Battle-Hardened";
    }
    else if (exp < 51){
      widget.cardModel.rank = "Heroic";
    }
    else {
      widget.cardModel.rank = "Legendary";
    }
  }

  void updateExp (int combatSwitch, int offset){

    int oldTotalDestroyed  = widget.cardModel.totalDestroyed;

    switch(combatSwitch){
      case 0: widget.cardModel.totalDestroyedPsychic += 1 * offset;
      break;

      case 1: widget.cardModel.totalDestroyedRanged += 1 * offset;
      break;

      case 2: widget.cardModel.totalDestroyedMelee += 1 * offset;
      break;
    }

    int totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
    widget.cardModel.totalDestroyed = totalDestroyed;

    if(oldTotalDestroyed > totalDestroyed && oldTotalDestroyed % 3 == 0){
      widget.cardModel.experiencePoints--;
    }
    if(oldTotalDestroyed < totalDestroyed && totalDestroyed % 3 == 0){
      widget.cardModel.experiencePoints++;
    }

    updateRank(widget.cardModel.experiencePoints);

    DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);

  }


  @override
  Widget build(BuildContext context){
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
                    controller: widget.cardNameController,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Rank"),
                SizedBox(width: 92,),
                Container(
                  padding: EdgeInsets.all(15.0),
                  width: 250.0,
                  child: Text(widget.cardModel.rank),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Power Rating"),
                SizedBox(width: 95,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.powerRating --;
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.powerRating.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.powerRating ++;
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
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
                    controller: widget.cardBattleFieldRoleController,
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
                    controller: widget.cardUnitTypeController,
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
                    controller: widget.cardEquipmentController,
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
                    controller: widget.cardPsychicPowersController,
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
                    controller: widget.cardWarlordTraitsController,
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
                    controller: widget.cardRelicsController,
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
                    controller: widget.cardOtherUpgradesController,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Battle Honors"),
                SizedBox(width: 53,),
                Container(
                  padding: EdgeInsets.all(15.0),
                  width: 250.0,
                  child: Text(widget.cardModel.battleHonors),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Battle Scars"),
                SizedBox(width: 63,),
                Container(
                  width: 250.0,
                  child: TextField(
                    decoration: InputDecoration(
                    ),
                    controller: widget.cardBattleScarsController,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Experience Points"),
                SizedBox(width: 77,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.cardModel.experiencePoints <= 0) return;
                      widget.cardModel.experiencePoints --;
                      int exp = widget.cardModel.experiencePoints;
                      updateRank(exp);
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.experiencePoints.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.experiencePoints ++;
                      int exp = widget.cardModel.experiencePoints;
                      updateRank(exp);
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Crusade Points"),
                SizedBox(width: 142,),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.crusadePoints.toString()),
                )
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Battles Played"),
                SizedBox(width: 101,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.cardModel.battlesPlayed <= 0) return;
                      widget.cardModel.battlesPlayed --;
                      widget.cardModel.experiencePoints --;
                      int exp = widget.cardModel.experiencePoints;
                      updateRank(exp);
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.battlesPlayed.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.battlesPlayed ++;
                      widget.cardModel.experiencePoints ++;
                      int exp = widget.cardModel.experiencePoints;
                      updateRank(exp);
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Total Enemies Destroyed"),
                SizedBox(width: 84,),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.totalDestroyed.toString()),
                )
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Total Destroyed w/ Psychic"),
                SizedBox(width: 21,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.cardModel.totalDestroyedPsychic <= 0) return;
                      updateExp(0, -1);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.totalDestroyedPsychic.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      updateExp(0, 1);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Total Destroyed w/ Ranged"),
                SizedBox(width: 22,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.cardModel.totalDestroyedRanged <= 0) return;
                      updateExp(1, -1);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.totalDestroyedRanged.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      updateExp(1, 1);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Total Destroyed w/ Melee"),
                SizedBox(width: 31,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.cardModel.totalDestroyedMelee <= 0) return;
                      updateExp(2, -1);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.totalDestroyedMelee.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      updateExp(2, 1);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Times Marked for Greatness"),
                SizedBox(width: 14,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.cardModel.timesMarkedForGreatness <= 0) return;
                      widget.cardModel.timesMarkedForGreatness--;
                      widget.cardModel.experiencePoints -= 3;
                      updateRank(widget.cardModel.experiencePoints);
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.cardModel.timesMarkedForGreatness.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.timesMarkedForGreatness++;
                      widget.cardModel.experiencePoints += 3;
                      updateRank(widget.cardModel.experiencePoints);
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
              ]
          ),
          RaisedButton(
            child: Text("Test popup button"),
            onPressed: (){
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog (
                    title: Text("TestPopup"),
                    content: Text("TestContent"),
                    actions: [
                      FlatButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
                        },
                      ),
                    ],
                  );
                }
              ).then((value) => {
                setState(() {
                  widget.cardModel.addBattleHonor("TestBattlehonor");
                  //widget.cardModel.battleHonors = "";
                  print("BattleHonors: ${widget.cardModel.battleHonors}");
                  DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                })
              });
            },
          ),
        ],
      ),
    );
  }

}