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

  void updateCard (int exp){
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
                SizedBox(width: 100,),
                Container(
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
                SizedBox(width: 41,),
                Container(
                  width: 250.0,
                  child: TextField(
                    decoration: InputDecoration(
                    ),
                    controller: widget.cardBattleHonorsController,
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
                SizedBox(width: 95,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.experiencePoints --;
                      int exp = widget.cardModel.experiencePoints;
                      updateCard(exp);
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
                      updateCard(exp);
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
                SizedBox(width: 95,),
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
                SizedBox(width: 95,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.battlesPlayed --;
                      widget.cardModel.experiencePoints --;
                      int exp = widget.cardModel.experiencePoints;
                      updateCard(exp);
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
                      updateCard(exp);
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
                SizedBox(width: 95,),
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
                SizedBox(width: 45,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.totalDestroyedPsychic --;
                      widget.cardModel.totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
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
                  child: Text(widget.cardModel.totalDestroyedPsychic.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.totalDestroyedPsychic ++;
                      widget.cardModel.totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
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
                Text("Total Destroyed w/ Ranged"),
                SizedBox(width: 45,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.totalDestroyedRanged --;
                      widget.cardModel.totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
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
                  child: Text(widget.cardModel.totalDestroyedRanged.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.totalDestroyedRanged ++;
                      widget.cardModel.totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
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
                Text("Total Destroyed w/ Melee"),
                SizedBox(width: 45,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.totalDestroyedMelee --;
                      widget.cardModel.totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
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
                  child: Text(widget.cardModel.totalDestroyedMelee.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.cardModel.totalDestroyedMelee ++;
                      widget.cardModel.totalDestroyed = widget.cardModel.totalDestroyedPsychic + widget.cardModel.totalDestroyedRanged + widget.cardModel.totalDestroyedMelee;
                      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                    });
                  },
                ),
              ]
          ),
        ],
      ),
    );
  }
}