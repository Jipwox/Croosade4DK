import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
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

  @override
  Widget build(BuildContext context) {
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
                      Text("Battle of "),
                      SizedBox(width: 100,),
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
              ],
            )
        )
    );
  }
}