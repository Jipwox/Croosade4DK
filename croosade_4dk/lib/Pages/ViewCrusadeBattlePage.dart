import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import 'package:croosade_4dk/Models/CardBattleEntryModel.dart';
import '../utils/Database.dart';
import '../Models/CrusadeCardModel.dart';

class ViewCrusadeBattlePage extends StatefulWidget {
  final CrusadeBattleModel battle;
  final List<CardBattleEntryModel> battleEntries;
  ViewCrusadeBattlePage({@required this.battle, @required this.battleEntries});

  @override
  _ViewCrusadeBattleState createState() => _ViewCrusadeBattleState();
}

class _ViewCrusadeBattleState extends State<ViewCrusadeBattlePage>{

  TextEditingController battleNameController = new TextEditingController();
  TextEditingController opposingForceNameController = new TextEditingController();
  TextEditingController infoController = new TextEditingController();
  DateTime battleDate;
  List<CrusadeCardModel> cardModels;

  Future<void> initRetrieveCardModels() async {

    widget.battleEntries.forEach((element) async {
      cardModels.add(await DatabaseProvider.db.getCrusadeCard(element.cardId));
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
    initRetrieveCardModels();
    battleDate = DateTime.parse(widget.battle.date);
    battleNameController.text = widget.battle.name;
    opposingForceNameController.text = widget.battle.opposingForceName;
    infoController.text = widget.battle.info;
    
    battleNameController.addListener(_updateFromControllers);
    opposingForceNameController.addListener(_updateFromControllers);
    infoController.addListener(_updateFromControllers);
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: initRetrieveCardModels(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
          return Scaffold(
            appBar: AppBar(title: Text("Battle of ${battleNameController.text}")),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20.0),),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Text("Battle of "),
                        SizedBox(width: 50,),
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
                        SizedBox(width: 61,),
                        Container(
                          width: 250.0,
                          child: TextField(
                            controller: opposingForceNameController,
                          ),
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
                  SizedBox( height: 15.0, ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Container(
                          width: 300,
                          child: TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Battle info, and notable events go here...",
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
    );
  }

  Widget _buildRow(CardBattleEntryModel entryModel) {
    CrusadeCardModel cardModel = cardModels.firstWhere((element) => element.id == entryModel.cardId);
    String title = "${cardModel.name}";
    return ListTile(
      title: Text(title),
    );
  }

}