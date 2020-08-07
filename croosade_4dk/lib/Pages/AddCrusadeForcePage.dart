import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../Models/CrusadeForceModel.dart';

class AddCrusadeForcePage extends StatefulWidget {

  final String title = "New Crusade Force";

  @override
  _AddCrusadeForceState createState() => _AddCrusadeForceState();
}

class _AddCrusadeForceState extends State<AddCrusadeForcePage> {

  TextEditingController forceNameController = new TextEditingController();
  TextEditingController forceFactionController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "crusade.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  List<CrusadeForceModel> forceModels = [new CrusadeForceModel("No Crusade Entries", "No Crusade Entries")];

  @override
  void initState(){
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory){
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if(fileExists) refresh();
    });
  }

  @override
  void dispose(){
    forceNameController.dispose();
    forceFactionController.dispose();
    super.dispose();
  }

  void createFile(List<CrusadeForceModel> content, Directory dir, String fileName){
    print("creating file");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = file.existsSync();
    file.writeAsStringSync(json.encode(content));

  }

  void refresh(){
    this.setState(() {
      var fileContent = json.decode(jsonFile.readAsStringSync());
      forceModels.clear();
      for(Map i in fileContent){
        forceModels.add(CrusadeForceModel.fromJson(i));
      }
    });
  }

  void writeToFile(String forceName, String forceFaction) {
    forceModels.add(new CrusadeForceModel(forceNameController.text, forceFactionController.text));
    if(forceModels.length > 1) forceModels.removeWhere((element) => element.name == "No Crusade Entries");
    if(!jsonFile.existsSync()){
      print("file doesn't exist");
      createFile(forceModels, dir, fileName);
    }
    print("writing to file");
    jsonFile.writeAsStringSync(json.encode(forceModels));
    refresh();
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
            onPressed: () => writeToFile(forceNameController.text, forceFactionController.text),
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
