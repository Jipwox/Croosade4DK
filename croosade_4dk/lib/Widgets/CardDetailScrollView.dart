import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CardDetailScrollView extends StatefulWidget {
  final CrusadeCardModel cardModel;
  TextEditingController cardNameController = new TextEditingController();
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
                        @required this.cardInfoController});

  @override
  _CardDetailScrollViewState createState() => _CardDetailScrollViewState();

}

class _CardDetailScrollViewState extends State<CardDetailScrollView>{

  String _imageFilePath;
  PickedFile _imageFile;
  ImagePicker imagePicker = new ImagePicker();


  Future getImage() async{
    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
      _imageFilePath = _imageFile.path;
      widget.cardModel.imagePath = _imageFilePath;
      DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
    });
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    widget.cardNameController.addListener(_updateFromControllers);
    widget.cardBattleFieldRoleController.addListener(_updateFromControllers);
    widget.cardUnitTypeController.addListener(_updateFromControllers);
    widget.cardEquipmentController.addListener(_updateFromControllers);
    widget.cardPsychicPowersController.addListener(_updateFromControllers);
    widget.cardWarlordTraitsController.addListener(_updateFromControllers);
    widget.cardRelicsController.addListener(_updateFromControllers);
    widget.cardOtherUpgradesController.addListener(_updateFromControllers);
    widget.cardInfoController.addListener(_updateFromControllers);

    _imageFilePath = widget.cardModel.imagePath;
  }

  @override
  void dispose(){
    widget.cardNameController.dispose();
    widget.cardBattleFieldRoleController.dispose();
    widget.cardUnitTypeController.dispose();
    widget.cardEquipmentController.dispose();
    widget.cardPsychicPowersController.dispose();
    widget.cardWarlordTraitsController.dispose();
    widget.cardRelicsController.dispose();
    widget.cardOtherUpgradesController.dispose();
    widget.cardInfoController.dispose();
    super.dispose();
  }

  _updateFromControllers(){
    widget.cardModel.name = widget.cardNameController.text;
    widget.cardModel.battlefieldRole = widget.cardBattleFieldRoleController.text;
    widget.cardModel.unitType = widget.cardUnitTypeController.text;
    widget.cardModel.equipment = widget.cardEquipmentController.text;
    widget.cardModel.psychicPowers = widget.cardPsychicPowersController.text;
    widget.cardModel.relics = widget.cardRelicsController.text;
    widget.cardModel.otherUpgrades = widget.cardOtherUpgradesController.text;
    widget.cardModel.info = widget.cardInfoController.text;

    DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
  }

  bool eligibleForHonor(){
    int honorCount = widget.cardModel.getBattleHonors().length;
    int exp = widget.cardModel.experiencePoints;
    if(exp > 5 && exp < 16 && honorCount < 1){
      return true;
    }
    else if(exp > 15 && exp < 31 && honorCount < 2){
      return true;
    }
    else if(exp > 30 && exp < 51 && honorCount < 3){
      return true;
    }
    else if (exp > 50 && honorCount < 4){
      return true;
    }
    else{
      return false;
    }
  }

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
      if(widget.cardModel.experiencePoints < 0) widget.cardModel.experiencePoints = 0;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
              Container(
                width: 250.0,
                child: _imageFilePath != "" ? GestureDetector(
                    child: Container(
                        child: Image.file(File(_imageFilePath)),
                    ),
                    onTap:(){
                      getImage();
                    }
                ): RaisedButton(
                  child: Text("Upload Image"),
                  onPressed: getImage,
                ),
              ),
            ]
          ),
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
                Column(
                  children: [
                    Text("Battle Honors"),
                  ],
                ),
                SizedBox(width: 43,),
                Column(
                  children: [
                    if(widget.cardModel.getBattleHonors().length > 0) Container(
                      padding: EdgeInsets.all(15.0),
                      width: 250.0,
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: widget.cardModel.getBattleHonors().map((honor) => RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(honor),
                              IconButton(
                                icon: Icon(Icons.highlight_off),
                                onPressed: () {
                                  setState(() {
                                    widget.cardModel.removeBattleHonor(honor);
                                    if(widget.cardModel.crusadePoints > 0){
                                      if(widget.cardModel.powerRating > 10) widget.cardModel.crusadePoints --;
                                      widget.cardModel.crusadePoints --;
                                    }
                                    DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                                  });
                                },
                              ),
                            ],
                          ),
                          onPressed: (){},
                        )).toList().cast<Widget>(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: eligibleForHonor()? Colors.blue : Colors.black,
                      ),
                      onPressed: (){
                        TextEditingController bhController = new TextEditingController();
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog (
                                title: Text("Add Battle Honor"),
                                content: Container(
                                  width: 250.0,
                                  child: TextField(
                                    decoration: InputDecoration(
                                    ),
                                    controller: bhController,
                                  ),
                                ),
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
                            if(bhController.text.length <= 0) return;
                            widget.cardModel.addBattleHonor(bhController.text);
                            if(widget.cardModel.powerRating > 10) widget.cardModel.crusadePoints ++;
                            widget.cardModel.crusadePoints ++;
                            DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                          })
                        });
                      },
                    ),
                  ],
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Column(
                  children: [
                    Text("Battle Scars"),
                  ],
                ),
                SizedBox(width: 53,),
                Column(
                  children: [
                    if(widget.cardModel.getBattleScars().length > 0) Container(
                      padding: EdgeInsets.all(15.0),
                      width: 250.0,
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: widget.cardModel.getBattleScars().map((scar) => RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(scar),
                              IconButton(
                                icon: Icon(Icons.highlight_off),
                                onPressed: () {
                                  setState(() {
                                    widget.cardModel.removeBattleScar(scar);
                                    widget.cardModel.crusadePoints ++;
                                    widget.cardModel.crusadePoints = 0;
                                    DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                                  });
                                },
                              ),
                            ],
                          ),
                          onPressed: (){},
                        )).toList().cast<Widget>(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (){
                        TextEditingController bsController = new TextEditingController();
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog (
                                title: Text("Add Battle Scar"),
                                content: Container(
                                  width: 250.0,
                                  child: TextField(
                                    decoration: InputDecoration(
                                    ),
                                    controller: bsController,
                                  ),
                                ),
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
                            if(bsController.text.length <= 0) return;
                            widget.cardModel.addBattleScar(bsController.text);
                            widget.cardModel.crusadePoints --;
                            DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
                          })
                        });
                      },
                    ),
                  ],
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
                      if(widget.cardModel.experiencePoints < 0) widget.cardModel.experiencePoints = 0;
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
                      if(widget.cardModel.experiencePoints < 0) widget.cardModel.experiencePoints = 0;
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
                      if(widget.cardModel.experiencePoints < 0) widget.cardModel.experiencePoints = 0;
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
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Container(
                  width: 300,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Unit info, and notable achievements go here...",
                      border: OutlineInputBorder(),
                    ),
                    controller: widget.cardInfoController,
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }

}