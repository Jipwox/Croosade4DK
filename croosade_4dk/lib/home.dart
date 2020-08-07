import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'CrusadeForceModel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File jsonFile;
  Directory dir;
  String fileName = "crusade.json";
  bool fileExists = false;
  List<CrusadeForceModel> forceModels = [new CrusadeForceModel("No Entries", "No Entries")];

  @override
  void initState(){
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory){
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if(fileExists){
        var fileContent = json.decode(jsonFile.readAsStringSync());
        for(Map i in fileContent){
          forceModels.add(CrusadeForceModel.fromJson(i));
        }
        if(forceModels.length > 1) forceModels.removeWhere((element) => element.name == "No Crusade Entries");
      } else {
        forceModels = [new CrusadeForceModel("No Crusade Entries", "No Crusade Entries")];
      }
    });
  }

  void refreshPage(){
    getApplicationDocumentsDirectory().then((Directory directory){
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if(fileExists) this.setState(() {
        var fileContent = json.decode(jsonFile.readAsStringSync());
        forceModels.clear();
        for(Map i in fileContent){
          forceModels.add(CrusadeForceModel.fromJson(i));
        }
        if(forceModels.length > 1) forceModels.removeWhere((element) => element.name == "No Crusade Entries");
      });
      else{
        forceModels = [new CrusadeForceModel("No Crusade Entries", "No Crusade Entries")];
      }
    });
  }

  void _navigateToAddCrusadeForcePage(){
    Navigator.pushNamed(context, '/AddCrusadeForcePage').then((value) {
      refreshPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _crusadeForceList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddCrusadeForcePage,
        tooltip: 'Add Crusade Force',
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: [
        RaisedButton(
          child: Text("Delete Entries"),
          onPressed: () => deleteFile(dir, fileName),
        ),
      ],// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _crusadeForceList() {
    return ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: forceModels.length,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(forceModels[i].name + " / " + forceModels[i].faction);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },);

  }

  Widget _buildRow(String forceName) {
    return ListTile(
      title: Text(forceName),             // ... to here.
      onTap: () {print("Force: $forceName was clicked");},
    );
  }

  void deleteFile(Directory dir, String fileName){
    File file = new File(dir.path + "/" + fileName);
    file.delete();
    setState(() {
      refreshPage();
    });
  }
}
