import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

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
  Map<String, dynamic> fileContent = {"No Entries" : "No Entries"};

  @override
  void initState(){
    super.initState();
    refreshPage();
  }

  void refreshPage(){
    getApplicationDocumentsDirectory().then((Directory directory){
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if(fileExists) this.setState(() {
        fileContent = json.decode(jsonFile.readAsStringSync());
      });
      else fileContent = {"No Entries" : "No Entries"};
    });
  }

  void _navigateToAddCrusadeForcePage(){
    Navigator.pushNamed(context, '/AddCrusadeForcePage').then((value) {
      setState(() {
        refreshPage();
      });
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
    var keys = fileContent.keys.toList();
    return ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: fileContent.keys.length,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(keys[i] + " / " + fileContent[keys[i]]);
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
