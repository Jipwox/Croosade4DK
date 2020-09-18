import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import 'package:croosade_4dk/Models/CardBattleEntryModel.dart';
import '../utils/Database.dart';
import '../Models/CrusadeCardModel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:croosade_4dk/utils/croosade_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BattleDetailScrollView extends StatefulWidget {
  final CrusadeBattleModel battle;
  final List<CardBattleEntryModel> battleEntries;
  final List<CrusadeCardModel> cardModels;
  final List<CrusadeCardModel> allCardModels;

  BattleDetailScrollView(this.battle,this.battleEntries, this.cardModels, this.allCardModels);

  @override
  _BattleDetailScrollViewState createState() => _BattleDetailScrollViewState();
}

class _BattleDetailScrollViewState extends State<BattleDetailScrollView>{

  TextEditingController battleNameController = new TextEditingController();
  TextEditingController opposingForceNameController = new TextEditingController();
  TextEditingController infoController = new TextEditingController();
  DateTime battleDate;
  Map<int,bool> checkedValues = new Map<int,bool>();
  Set<int> checkedIds = new Set<int>();
  int victorious;

  String _imageFilePath;
  PickedFile _imageFile;
  ImagePicker imagePicker = new ImagePicker();

  MediaQueryData queryData;


  Future getImage() async{
    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
      _imageFilePath = _imageFile.path;
      widget.battle.imagePath = _imageFilePath;
      DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
    });
  }

  _updateFromControllers(){
    widget.battle.name = battleNameController.text;
    widget.battle.opposingForceName = opposingForceNameController.text;
    widget.battle.info = infoController.text;

    DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
  }

  @override
  void dispose(){
    battleNameController.dispose();
    opposingForceNameController.dispose();
    infoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    battleDate = DateTime.parse(widget.battle.date);
    battleNameController.text = widget.battle.name;
    opposingForceNameController.text = widget.battle.opposingForceName;
    infoController.text = widget.battle.info;
    victorious = widget.battle.victorious;

    battleNameController.addListener(_updateFromControllers);
    opposingForceNameController.addListener(_updateFromControllers);
    infoController.addListener(_updateFromControllers);

    _imageFilePath = widget.battle.imagePath;
  }

  void updateExp (int combatSwitch, int offset, CrusadeCardModel cardModel, CardBattleEntryModel battleEntry, int cardModelsIndex, int battleEntriesIndex){

    int oldTotalDestroyed  = cardModel.totalDestroyed;

    switch(combatSwitch){
      case 0:
        cardModel.totalDestroyedPsychic += 1 * offset;
        battleEntry.totalDestroyedPsychic += 1 * offset;
      break;

      case 1:
        cardModel.totalDestroyedRanged += 1 * offset;
        battleEntry.totalDestroyedRanged += 1 * offset;
      break;

      case 2:
        cardModel.totalDestroyedMelee += 1 * offset;
        battleEntry.totalDestroyedMelee += 1 * offset;
      break;
    }

    int cardTotalDestroyed = cardModel.totalDestroyedPsychic + cardModel.totalDestroyedRanged + cardModel.totalDestroyedMelee;
    int entryTotalDestroyed = battleEntry.totalDestroyedPsychic + battleEntry.totalDestroyedRanged + battleEntry.totalDestroyedMelee;
    cardModel.totalDestroyed = cardTotalDestroyed;
    battleEntry.totalDestroyed = entryTotalDestroyed;

    if(oldTotalDestroyed > cardTotalDestroyed && oldTotalDestroyed % 3 == 0){
      cardModel.experiencePoints--;
      if(cardModel.experiencePoints < 0) cardModel.experiencePoints = 0;
    }
    if(oldTotalDestroyed < cardTotalDestroyed && cardTotalDestroyed % 3 == 0){
      cardModel.experiencePoints++;
    }

    cardModel.rank = getRank(cardModel.experiencePoints);

    DatabaseProvider.db.updateCrusadeCardModel(cardModel);
    widget.cardModels[cardModelsIndex] = cardModel;

    DatabaseProvider.db.updateCardBattleEntryModel(battleEntry);
    widget.battleEntries[battleEntriesIndex] = battleEntry;

  }

  void updateExpMFG (CrusadeCardModel cardModel, CardBattleEntryModel battleEntry, int offset, int cardModelsIndex, int battleEntriesIndex){
    cardModel.experiencePoints += 3 * offset;
    cardModel.timesMarkedForGreatness+= 1 * offset;
    cardModel.rank = getRank(cardModel.experiencePoints);

    DatabaseProvider.db.updateCrusadeCardModel(cardModel);
    widget.cardModels[cardModelsIndex] = cardModel;

    DatabaseProvider.db.updateCardBattleEntryModel(battleEntry);
    widget.battleEntries[battleEntriesIndex] = battleEntry;
  }

  String getRank (int exp){

    if(exp < 6){
      return "Battle-Ready";
    }
    else if (exp < 16){
      return "Blooded";
    }
    else if (exp < 31){
      return "Battle-Hardened";
    }
    else if (exp < 51){
      return "Heroic";
    }
    else {
      return "Legendary";
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: battleDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != battleDate)
      setState(() {
        battleDate = picked;
        widget.battle.date = battleDate.toString();
        DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
      });
  }

  @override
  Widget build(BuildContext context){
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Battle of ${battleNameController.text}")),
      body: SingleChildScrollView(
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
                  Text("Battle of "),
                  SizedBox(width: queryData.size.width/8.1,),
                  Container(
                    width: 250.0,
                    child: Focus(
                      child: TextField(
                        controller: battleNameController,
                      ),
                      onFocusChange: (hasFocus){if(!hasFocus){setState(() {});}},
                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                  Text("Versus "),
                  SizedBox(width: queryData.size.width/6.8,),
                  Container(
                    width: 250.0,
                    child: TextField(
                      controller: opposingForceNameController,
                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                  Text("Date "),
                  SizedBox(width: queryData.size.width/5.5,),
                  Text("${battleDate.month}/${battleDate.day}/${battleDate.year}"),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => _selectDate(context),
                  ),
                ]
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              itemCount: widget.battleEntries.length,
              itemBuilder: /*1*/ (context, i) {
                return _buildRow(widget.battleEntries[i]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.battleEntries.length != widget.allCardModels.length) IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          List<CrusadeCardModel> difference = new List<CrusadeCardModel>();
                          Set<int> cardModelsIds = new Set();
                          Set<int> allCardModelsIds = new Set();
                          widget.cardModels.forEach((element) {
                            cardModelsIds.add(element.id);
                          });
                          widget.allCardModels.forEach((element) {
                            allCardModelsIds.add(element.id);
                          });
                          Set<int> differenceSet = allCardModelsIds.difference(cardModelsIds);
                          differenceSet.forEach((element) {
                            difference.add(widget.allCardModels.firstWhere((element2) => element2.id == element));
                          });

                          difference.forEach((element) {
                            checkedValues[element.id] = false;
                            print(element.id.toString());
                          });

                          return AlertDialog (
                            title: Text("Add Units"),
                            content: Container(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(16.0),
                                      itemCount: difference.length,
                                      itemBuilder: /*1*/ (context, i) {
                                        return _buildAddEntryRow(difference[i]);
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },),
                                  ),
                                  RaisedButton(
                                    child: Text("Save"),
                                    onPressed: () {
                                      setState(() {
                                        addBattleEntries();
                                      });
                                    },
                                  ),
                                ],
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
                      })
                    });
                  },
                ),
              ],
            ),
            SizedBox( height: 15.0, ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Victory"),
                    Radio(
                      value: 2,
                      groupValue: victorious,
                      onChanged: (int value){
                        setState(() {
                          victorious = value;
                          widget.battle.victorious = victorious;
                          DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
                        });
                      },
                    )
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  children: [
                    Text("Stalemate"),
                    Radio(
                      value: 0,
                      groupValue: victorious,
                      onChanged: (int value){
                        setState(() {
                          victorious = value;
                          widget.battle.victorious = victorious;
                          DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
                        });
                      },
                    )
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  children: [
                    Text("Defeat"),
                    Radio(
                      value: 1,
                      groupValue: victorious,
                      onChanged: (int value){
                        setState(() {
                          victorious = value;
                          widget.battle.victorious = victorious;
                          DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox( height: 15.0, ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0,),),
                  Container(
                    width: 300,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Battle info and notable events go here...",
                        border: OutlineInputBorder(),
                      ),
                      controller: infoController,
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }

  void addBattleEntries(){
    checkedIds.forEach((element) {
      widget.battle.addBattleUnit(element);
      DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
      DatabaseProvider.db.incrementCrusadeCardModelBattlesPlayed(element, 1);
      CardBattleEntryModel cardBattleEntryModel = new CardBattleEntryModel(element, widget.battle.id);
      DatabaseProvider.db.insertCardBattleEntryModel(cardBattleEntryModel);
      widget.battleEntries.add(cardBattleEntryModel);
      widget.cardModels.add(widget.allCardModels.firstWhere((element2) => element2.id == element));
    });
    checkedIds.clear();
    Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
  }

  Widget _buildAddEntryRow(CrusadeCardModel cardModel) {
    String title = "${cardModel.name} / PR: ${cardModel.powerRating} / ${cardModel.rank}";
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return CheckboxListTile(
            title: Text(title),
            controlAffinity: ListTileControlAffinity.leading,
            value: checkedValues[cardModel.id],
            onChanged: (bool value){
              print("checkValue = $value");
              setState(() {
                checkedValues[cardModel.id] = value;
                if(value)checkedIds.add(cardModel.id);
                if(!value) checkedIds.remove(cardModel.id);
              });
            },
          );
        }
    );
  }

  Widget _buildRow(CardBattleEntryModel entryModel) {
    CrusadeCardModel cardModel = widget.cardModels.firstWhere((element) => element.id == entryModel.cardId);
    int cardModelsIndex = widget.cardModels.indexOf(cardModel);
    int battleEntriesIndex = widget.battleEntries.indexOf(entryModel);
    String title = cardModel.unitType == "" ? "${cardModel.name}" : "${cardModel.name} / ${cardModel.unitType}";
    bool markedForGreatness = entryModel.markedForGreatness == 0 ? false : true;
    bool kia = entryModel.kia == 0 ? false : true;
    return Ink(
      color: markedForGreatness ? Colors.amber : null,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title)
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(Croosade.explosion),
                Text(entryModel.totalDestroyedPsychic.toString())
              ],
            ),
            Column(
              children: [
                Icon(Croosade.arrow_cluster),
                Text(entryModel.totalDestroyedRanged.toString())
              ],
            ),
            Column(
              children: [
                Icon(Croosade.crossed_swords),
                Text(entryModel.totalDestroyedMelee.toString())
              ],
            ),
            SizedBox(width: 40,),
            Column(
              children: [
                Text("A1"),
                Text(entryModel.agenda1Tally.toString())
              ],
            ),
            SizedBox(width: 5,),
            Column(
              children: [
                Text("A2"),
                Text(entryModel.agenda2Tally.toString())
              ],
            ),
            SizedBox(width: 5,),
            Column(
              children: [
                Text("A3"),
                Text(entryModel.agenda3Tally.toString())
              ],
            ),
          ],
        ),
        leading: kia ? Icon(MdiIcons.skull) : null,
        onTap: () => {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog (
                  title: Text(title),
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState){
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                                  Icon(Croosade.explosion),
                                  SizedBox(width: 50,),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        if(entryModel.totalDestroyedPsychic <= 0) return;
                                        updateExp(0, -1, cardModel, entryModel , cardModelsIndex, battleEntriesIndex);
                                      });
                                    },
                                  ),
                                  Text(entryModel.totalDestroyedPsychic.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        updateExp(0, 1, cardModel, entryModel , cardModelsIndex, battleEntriesIndex);
                                      });
                                    },
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                                  Icon(Croosade.arrow_cluster),
                                  SizedBox(width: 50,),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        if(entryModel.totalDestroyedRanged <= 0) return;
                                        updateExp(1, -1, cardModel, entryModel , cardModelsIndex, battleEntriesIndex);
                                      });
                                    },
                                  ),
                                  Text(entryModel.totalDestroyedRanged.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        updateExp(1, 1, cardModel, entryModel , cardModelsIndex, battleEntriesIndex);
                                      });
                                    },
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                                  Icon(Croosade.crossed_swords),
                                  SizedBox(width: 50,),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        if(entryModel.totalDestroyedMelee <= 0) return;
                                        updateExp(2, -1, cardModel, entryModel , cardModelsIndex, battleEntriesIndex);
                                      });
                                    },
                                  ),
                                  Text(entryModel.totalDestroyedMelee.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        updateExp(2, 1, cardModel, entryModel , cardModelsIndex, battleEntriesIndex);
                                      });
                                    },
                                  ),
                                ]
                            ),
                            SizedBox(height: 25,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                                  Text("Agenda 1"),
                                  SizedBox(width: 0,),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        if(entryModel.agenda1Tally <= 0) return;
                                        entryModel.agenda1Tally -= 1;
                                        DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                        widget.battleEntries[battleEntriesIndex] = entryModel;
                                      });
                                    },
                                  ),
                                  Text(entryModel.agenda1Tally.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        entryModel.agenda1Tally += 1;
                                        DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                        widget.battleEntries[battleEntriesIndex] = entryModel;
                                      });
                                    },
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                                  Text("Agenda 2"),
                                  SizedBox(width: 0,),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        if(entryModel.agenda2Tally <= 0) return;
                                        entryModel.agenda2Tally -= 1;
                                        DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                        widget.battleEntries[battleEntriesIndex] = entryModel;
                                      });
                                    },
                                  ),
                                  Text(entryModel.agenda2Tally.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        entryModel.agenda2Tally += 1;
                                        DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                        widget.battleEntries[battleEntriesIndex] = entryModel;
                                      });
                                    },
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                                  Text("Agenda 3"),
                                  SizedBox(width: 0,),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        if(entryModel.agenda3Tally <= 0) return;
                                        entryModel.agenda3Tally -= 1;
                                        DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                        widget.battleEntries[battleEntriesIndex] = entryModel;
                                      });
                                    },
                                  ),
                                  Text(entryModel.agenda3Tally.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        entryModel.agenda3Tally += 1;
                                        DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                        widget.battleEntries[battleEntriesIndex] = entryModel;
                                      });
                                    },
                                  ),
                                ]
                            ),
                            CheckboxListTile(
                              title: Text("KIA"),
                              value: kia,
                              onChanged: (newValue) {
                                setState(() {
                                  kia = newValue;
                                  entryModel.kia = kia ? 1 : 0;
                                  DatabaseProvider.db.updateCardBattleEntryModel(entryModel);
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              title: Text("Marked For Greatness"),
                              value: markedForGreatness,
                              onChanged: (newValue) {
                                setState(() {
                                  markedForGreatness = newValue;
                                  int offset = markedForGreatness ? 1 : -1;
                                  entryModel.markedForGreatness = markedForGreatness ? 1 : 0;
                                  updateExpMFG(cardModel, entryModel, offset, cardModelsIndex, battleEntriesIndex);
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                            ),
                          ],
                        ),
                      );
                    }
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
            })
          })
        },
        trailing: IconButton(
          icon: Icon(
            Icons.highlight_off,
          ),
          onPressed: (){
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog (
                    title: Text("Are you sure you want to delete $title ?"),
                    actions: [
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
                        },
                      ),
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          DatabaseProvider.db.deleteCardBattleEntryModel(entryModel.id);
                          widget.battleEntries.removeWhere((element) => element.id == entryModel.id);
                          widget.cardModels.removeWhere((element) => element.id == entryModel.cardId);
                          Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
                        },
                      ),
                    ],
                  );
                }
            ).then((value) => {
              setState(() {
              })
            });
          },
        ),
      ),
    );
  }
}