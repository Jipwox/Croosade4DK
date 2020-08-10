import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';

class AddCrusadeForcePage extends StatefulWidget {

  final String title = "New Crusade Force";

  @override
  _AddCrusadeForceState createState() => _AddCrusadeForceState();
}

class _AddCrusadeForceState extends State<AddCrusadeForcePage> {

  TextEditingController forceNameController = new TextEditingController();
  TextEditingController forceFactionController = new TextEditingController();

  List<CrusadeForceModel> forceModels = [];

  @override
  void initState(){
    super.initState();
    retrieveModels();
  }

  void retrieveModels() async {
    forceModels = await DatabaseProvider.db.getCrusadeForces();
  }

  void refreshPage(){
    setState(() {
      retrieveModels();
    });
  }

  @override
  void dispose(){
    forceNameController.dispose();
    forceFactionController.dispose();
    super.dispose();
  }


  void writeToDB(String forceName, String forceFaction) async {
    var crusadeForceModel = CrusadeForceModel(forceNameController.text, forceFactionController.text);
    await DatabaseProvider.db.insertCrusadeForceModel(crusadeForceModel);

    refreshPage();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0,),),
                  Text("Force Name"),
                  SizedBox(height: 30,),
                  Text("Force Faction"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0,),),
                  Container(
                    width: 250.0,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Name your Crusade force"
                      ),
                      controller: forceNameController,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Choose your Crusade faction"
                      ),
                      controller: forceFactionController,
                    ),
                  ),
                ],
              ),
            ],
          ),
          RaisedButton(
            child: Text("Save"),
            onPressed: () => writeToDB(forceNameController.text, forceFactionController.text),
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
