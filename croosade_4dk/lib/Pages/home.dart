import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<CrusadeForceModel> forceModels = [];

  Future<List<CrusadeForceModel>> retrieveModels() async {
    forceModels = await DatabaseProvider.db.getCrusadeForces();
    return forceModels;
  }

  @override
  void initState(){
    super.initState();
    retrieveModels();
  }

  void refreshPage(){
    setState(() {
      retrieveModels();
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
          onPressed: () => deleteForces(),
        ),
      ],// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _crusadeForceList() {
    refreshPage();
    return FutureBuilder(
      future: retrieveModels(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
          return ListView.separated(
            padding: EdgeInsets.all(16.0),
            itemCount: forceModels.length,
            itemBuilder: /*1*/ (context, i) {
              return _buildRow(forceModels[i].name + " / " + forceModels[i].faction);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },);
        },
    );

  }

  Widget _buildRow(String forceName) {
    return ListTile(
      title: Text(forceName),             // ... to here.
      onTap: () {print("Force: $forceName was clicked");},
    );
  }

  void deleteForces() async{
    await DatabaseProvider.db.deleteCrusadeForceModels();
    refreshPage();
  }
}
