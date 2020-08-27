import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import '../utils/Database.dart';

class ViewCrusadeBattlePage extends StatefulWidget {
  final CrusadeBattleModel battle;
  ViewCrusadeBattlePage({@required this.battle});

  @override
  _ViewCrusadeBattleState createState() => _ViewCrusadeBattleState();
}

class _ViewCrusadeBattleState extends State<ViewCrusadeBattlePage>{

  TextEditingController battleNameController = new TextEditingController();

  _updateFromControllers(){
    widget.battle.name = battleNameController.text;

    DatabaseProvider.db.updateCrusadeBattleModel(widget.battle);
  }

  @override
  void dispose(){
    battleNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    battleNameController.text = widget.battle.name;
    
    battleNameController.addListener(_updateFromControllers);
  }

  @override
  Widget build(BuildContext context){
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
          ],
        ),
      ),
    );
  }

}