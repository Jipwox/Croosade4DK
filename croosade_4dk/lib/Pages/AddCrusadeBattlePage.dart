import 'package:croosade_4dk/Models/CardBattleEntryModel.dart';
import 'package:croosade_4dk/Models/CrusadeForceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import '../Models/CrusadeCardModel.dart';
import '../utils/Database.dart';

class AddCrusadeBattlePage extends StatefulWidget {
  final String title = "New Battle!";
  final int crusadeForceId;

  AddCrusadeBattlePage({@required this.crusadeForceId});

  @override
  _AddCrusadeBattleState createState() => _AddCrusadeBattleState();
}

class _AddCrusadeBattleState extends State<AddCrusadeBattlePage>{
  TextEditingController battleNameController = new TextEditingController();
  TextEditingController opposingForceNameController = new TextEditingController();
  TextEditingController infoController = new TextEditingController();
  TextEditingController date = new TextEditingController();
  List<CrusadeCardModel> cardModels = new List<CrusadeCardModel>();
  DateTime selectedDate = DateTime.now();
  Set<int> checkedIds = new Set<int>();
  Map<int,bool> checkedValues = new Map<int,bool>();
  CrusadeForceModel forceModel;
  MediaQueryData queryData;
  var totalPowerLevel = 0;
  var currentPowerLevel = 0;
  var totalCrusadePoints = 0;
  var currentCrusadePoints = 0;

  Future<List<CrusadeCardModel>> initRetrieveCardModels() async {
    cardModels = await DatabaseProvider.db.getCrusadeCards(widget.crusadeForceId);
    forceModel = await DatabaseProvider.db.getCrusadeForce(widget.crusadeForceId);

    cardModels.forEach((element) {
      checkedIds.add(element.id);
      checkedValues[element.id] = true;
      totalPowerLevel += element.powerRating;
      totalCrusadePoints += element.crusadePoints;
    });

    currentPowerLevel = totalPowerLevel;
    currentCrusadePoints = totalCrusadePoints;

    return cardModels;
  }

  Future<List<CrusadeCardModel>> retrieveCardModels() async {
    cardModels = await DatabaseProvider.db.getCrusadeCards(widget.crusadeForceId);

    return cardModels;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void uncheckAll(){
    setState(() {
      checkedValues.forEach((key, value) {
        checkedValues[key] = false;
        checkedIds.clear();
        currentPowerLevel = 0;
        currentCrusadePoints = 0;
      });
    });
  }

  void checkAll(){
    setState(() {
      checkedValues.forEach((key, value) {
        checkedValues[key] = true;
        checkedIds.add(key);
        currentPowerLevel = totalPowerLevel;
        currentCrusadePoints = totalCrusadePoints;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    initRetrieveCardModels();
  }

  void refreshPage(){
    setState(() {
      retrieveCardModels();
    });
  }

  void insertCrusadeBattle() async{
    if(battleNameController.text == "" || checkedIds.length == 0) return;
    List<int> checkedIdList = checkedIds.toList();
    CrusadeBattleModel battle = new CrusadeBattleModel(
        battleNameController.text,
        widget.crusadeForceId,
        opposingForceNameController.text,
        infoController.text,
        selectedDate.toString()
    );
    battle.addBattleUnits(checkedIdList);

    await DatabaseProvider.db.insertCrusadeBattleModel(battle);

    checkedIds.forEach((element) async {
      print(element);
      DatabaseProvider.db.incrementCrusadeCardModelBattlesPlayed(element, 1);
      CardBattleEntryModel cardBattleEntryModel = new CardBattleEntryModel(element, battle.id);
      await DatabaseProvider.db.insertCardBattleEntryModel(cardBattleEntryModel);
    });

    DatabaseProvider.db.incrementCrusadeForceBattleTally(widget.crusadeForceId, 1);
    if(forceModel.requisitionPoints < 5) DatabaseProvider.db.incrementCrusadeForceRequisitionPoints(widget.crusadeForceId, 1);

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    refreshPage();
    return Scaffold(
        appBar: AppBar(title: Text(widget.title),),
        body: FutureBuilder(
            future: retrieveCardModels(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20.0),),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Text("Battle of "),
                            SizedBox(width: queryData.size.width/5.15,),
                            Container(
                              width: 250.0,
                              child: TextField(
                                decoration: InputDecoration(
                                ),
                                controller: battleNameController,
                              ),
                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Text("Opposing Force "),
                            SizedBox(width: queryData.size.width/11.5,),
                            Container(
                              width: 250.0,
                              child: TextField(
                                decoration: InputDecoration(
                                ),
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
                            SizedBox(width: queryData.size.width/3.9,),
                            Text("${selectedDate.month}/${selectedDate.day}/${selectedDate.year}"),
                            IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () => _selectDate(context),
                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Text("Participating Units: "),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            RaisedButton(
                              child: Text("Uncheck All"),
                              onPressed: () => {
                                uncheckAll()
                              },
                            ),
                            SizedBox(width: 20,),
                            RaisedButton(
                              child: Text("Check All"),
                              onPressed: () => {
                                checkAll()
                              },
                            ),
                          ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                          Text("Power Level: " + currentPowerLevel.toString() + "     Crusade Points: " + currentCrusadePoints.toString()),
                        ],
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16.0),
                        itemCount: cardModels.length,
                        itemBuilder: /*1*/ (context, i) {
                          return _buildRow(cardModels[i]);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Container(
                              width: 300,
                              child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Battle details / notable events...",
                                  border: OutlineInputBorder(),
                                ),
                                controller: infoController,
                              ),
                            ),
                          ]
                      ),
                      RaisedButton(
                        child: Text("Save"),
                        onPressed: () => {
                          insertCrusadeBattle()
                        },
                      ),
                    ],
                  )
              );
            }
        )
    );
  }


  Widget _buildRow(CrusadeCardModel cardModel) {
    String title = "${cardModel.name} / PR: ${cardModel.powerRating} / CP: ${cardModel.crusadePoints} / ${cardModel.rank}";
    return CheckboxListTile(
      tristate: true,
      title: Text(title),
      controlAffinity: ListTileControlAffinity.leading,
      value: checkedValues[cardModel.id],
      onChanged: (bool value){
        print(value);
        setState(() {
          checkedValues[cardModel.id] = value;
          if(value){
            checkedIds.add(cardModel.id);
            currentPowerLevel += cardModel.powerRating;
            currentCrusadePoints += cardModel.crusadePoints;
          }
          if(!value){
            checkedIds.remove(cardModel.id);
            currentPowerLevel -= cardModel.powerRating;
            currentCrusadePoints -= cardModel.crusadePoints;
          }
          print(checkedIds);
        });
      },
    );
  }
}