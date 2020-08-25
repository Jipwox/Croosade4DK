import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'CrusadeForceDetailTab.dart';
import 'CrusadeCardListTab.dart';
import 'CrusadeBattleTab.dart';
import 'TapMeButton.dart';

class ViewCrusadeForcePage extends StatefulWidget {
  final String title;
  final int id;
  ViewCrusadeForcePage({@required this.title, @required this.id});

  @override
  _ViewCrusadeForceState createState() => _ViewCrusadeForceState();
}

class _ViewCrusadeForceState extends State<ViewCrusadeForcePage> {

  CrusadeForceModel forceModel;

  @override
  void initState(){
    super.initState();
    retrieveModel();
  }


  Future<CrusadeForceModel> retrieveModel() async {
    forceModel = await DatabaseProvider.db.getCrusadeForce(widget.id);

    return forceModel;
  }

  void refreshPage(){
    setState(() {
      retrieveModel();
    });
  }

  void updateForceModel(CrusadeForceModel crusadeForceModel) async {
    await DatabaseProvider.db.updateCrusadeForceModel(crusadeForceModel);

    refreshPage();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    refreshPage();
    return FutureBuilder(
      future: retrieveModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(title: Text(widget.title),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.toc),),
                  Tab(icon: Icon(Icons.group_add)),
                  Tab(icon: new Icon(MdiIcons.sword)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                CrusadeForceDetailTab(forceModel: forceModel,),
                CrusadeCardListTab(forceModel: forceModel,),
                CrusadeBattleTab(forceModel: forceModel),
              ],
            ),// This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      },
    );
  }
}
