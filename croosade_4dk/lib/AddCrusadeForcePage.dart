import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

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

  @override
  void initState(){
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory){
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if(fileExists) this.setState(() {
        fileContent = json.decode(jsonFile.readAsStringSync());
      });
    });
  }

  @override
  void dispose(){
    forceNameController.dispose();
    forceFactionController.dispose();
    super.dispose();
  }

  void createFile(Map<String, dynamic> content, Directory dir, String fileName){
    print("creating file");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = file.existsSync();
    file.writeAsStringSync(json.encode(content));

  }

  void writeToFile(String key, dynamic value) {
    Map<String, dynamic> content = {key: value};
    if(!jsonFile.existsSync()){
      print("file doesn't exist");
      createFile(content, dir, fileName);
    }
    print("writing to file");
    Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
    jsonFileContent.addAll(content);
    jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    this.setState(() {
      fileContent = json.decode(jsonFile.readAsStringSync());
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0),),
          Text("Force Name"),
          TextField(controller: forceNameController,),
          Text("Force Faction"),
          TextField(controller: forceFactionController,),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          RaisedButton(
            child: Text("Save"),
            onPressed: () => writeToFile(forceNameController.text, forceFactionController.text ),
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
