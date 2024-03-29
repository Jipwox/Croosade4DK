import 'package:croosade_4dk/Models/CardBattleEntryModel.dart';
import 'package:croosade_4dk/Pages/AddCrusadeBattlePage.dart';
import 'package:croosade_4dk/Pages/ViewCrusadeBattlePage.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CrusadeBattleTab extends StatefulWidget{

  final CrusadeForceModel forceModel;

  CrusadeBattleTab({@required this.forceModel});

  @override
  _CrusadeBattleTabState createState() => _CrusadeBattleTabState();
}

class _CrusadeBattleTabState extends State<CrusadeBattleTab> {

  List<CrusadeBattleModel> battles = [];

  @override
  void initState(){
    super.initState();
    retrieveBattles();
  }

  void refreshPage(){
    setState(() {
      retrieveBattles();
    });
  }

  Future<List<CrusadeBattleModel>> retrieveBattles() async{
    battles = await DatabaseProvider.db.getCrusadeBattles(widget.forceModel.id);
    return battles;
  }

  _navigateToAddBattlePage(int forceId) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddCrusadeBattlePage(crusadeForceId: forceId)
        )
    );

    refreshPage();
  }

  void _navigateToViewCrusadeBattlePage(BuildContext context, CrusadeBattleModel battleModel) async{

    List<CardBattleEntryModel> battleEntryList =  await DatabaseProvider.db.getCardBattleEntryModels(battleModel.id);

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewCrusadeBattlePage(battle: battleModel, battleEntries: battleEntryList,)
        )
    );
    refreshPage();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
          future: retrieveBattles(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
            return ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemCount: battles.length,
              itemBuilder: /*1*/ (context, i) {
                return _buildRow(battles[i]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddBattlePage(widget.forceModel.id),
        tooltip: 'Battle!',
        child: Icon(Icons.add),
      ),
    );
  }

  Icon getBattleIcon(int battleStatus){
    if(battleStatus == 2){
      return Icon(Icons.flag);
    }
    else if (battleStatus == 1){
      return Icon(MdiIcons.skull);
    }
    else return Icon(MdiIcons.swordCross);
  }

  Widget _buildRow(CrusadeBattleModel battle) {
    DateTime parsedDate = DateTime.parse(battle.date);
    String title = "Battle of ${battle.name} - ${parsedDate.month}/${parsedDate.day}/${parsedDate.year}";
    return ListTile(
      title: Text(title),
      leading: getBattleIcon(battle.victorious),
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
                      onPressed: () async {
                        await DatabaseProvider.db.deleteCrusadeBattleModel(battle.id);
                        Navigator.of(context).pop(true); //supposedly the "true" param will refresh the UI on pop
                      },
                    ),
                  ],
                );
              }
          ).then((value) => {
            refreshPage()
          });
        },
      ),
      onTap: () {
        _navigateToViewCrusadeBattlePage(context, battle);
      },
    );
  }
}