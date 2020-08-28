import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import 'package:croosade_4dk/Models/CardBattleEntryModel.dart';
import '../utils/Database.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/Widgets/BattleDetailScrollView.dart';

class ViewCrusadeBattlePage extends StatefulWidget {
  final CrusadeBattleModel battle;
  final List<CardBattleEntryModel> battleEntries;
  ViewCrusadeBattlePage({@required this.battle, @required this.battleEntries});

  @override
  _ViewCrusadeBattleState createState() => _ViewCrusadeBattleState();
}

class _ViewCrusadeBattleState extends State<ViewCrusadeBattlePage>{

  List<CrusadeCardModel> cardModels = new List<CrusadeCardModel>();
  List<CrusadeCardModel> allCardModels = new List<CrusadeCardModel>();

  Future<void> initRetrieveCardModels() async {

    widget.battleEntries.forEach((element) async {
      cardModels.add(await DatabaseProvider.db.getCrusadeCard(element.cardId));
    });

    allCardModels = await DatabaseProvider.db.getCrusadeCards(widget.battle.crusadeId);

  }



  @override
  void initState() {
    super.initState();
    initRetrieveCardModels();
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: initRetrieveCardModels(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
          return BattleDetailScrollView(widget.battle, widget.battleEntries, cardModels, allCardModels);
        }
    );
  }


}