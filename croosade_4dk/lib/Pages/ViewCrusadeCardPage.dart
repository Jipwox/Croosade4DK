import 'package:croosade_4dk/Models/CrusadeCardModel.dart';
import 'package:flutter/material.dart';
import '../utils/Database.dart';
import 'TapMeButton.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:croosade_4dk/Pages/CrusadeCardDetailTab.dart';

class ViewCrusadeCardPage extends StatefulWidget {
  final int cardId;
  ViewCrusadeCardPage({@required this.cardId});

  @override
  _ViewCrusadeCardState createState() => _ViewCrusadeCardState();
}

class _ViewCrusadeCardState extends State<ViewCrusadeCardPage>{

  CrusadeCardModel cardModel;

  @override
  void initState(){
    super.initState();
    retrieveModel();
  }

  void refreshPage(){
    setState(() {
      retrieveModel();
    });
  }

  Future<CrusadeCardModel> retrieveModel() async {
    cardModel = await DatabaseProvider.db.getCrusadeCard(widget.cardId);

    return cardModel;
  }

  void updateCardModel(CrusadeCardModel crusadeCardModel) async {
    await DatabaseProvider.db.updateCrusadeCardModel(crusadeCardModel);

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
          length: 2,
          child: Scaffold(
            appBar: AppBar(title: Text(cardModel.name),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.toc),),
                  Tab(icon: new Icon(MdiIcons.sword)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                CrusadeCardDetailTab(cardModel: cardModel,),
                CustomButton(
                  onPressed: () {
                    print("Tapped Me");
                  },
                ),
              ],
            ),// This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      },
    );
  }

}