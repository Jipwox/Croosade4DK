import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';
import 'ViewCrusadeForcePage.dart';

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

  void _navigateToViewCrusadeForcePage(BuildContext context, forceTitle, forceId) async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewCrusadeForcePage(title: forceTitle, id: forceId)
      )
    );

    refreshPage();
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
              return _buildRow(forceModels[i]);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },);
        },
    );

  }

  Widget _buildRow(CrusadeForceModel forceModel) {
    String title = "${forceModel.name} / ${forceModel.faction}";
    return ListTile(
      title: Text(title),
      trailing: IconButton(
        icon: Icon(
          Icons.highlight_off,
        ),
        onPressed: (){
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog (
                  title: Text("Are you sure you want to delete $title ?"),
                  actions: [
                    FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
                      },
                    ),
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        DatabaseProvider.db.deleteCrusadeForceModel(forceModel.id);
                        Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
                      },
                    ),
                  ],
                );
              }
          ).then((value) => {
            setState(() {
            })
          });
        },
      ),
      onTap: () {
        _navigateToViewCrusadeForcePage(context, title, forceModel.id);
      },
    );
  }

  void deleteForces() async{
    await DatabaseProvider.db.deleteCrusadeForceModels();
    refreshPage();
  }
}
