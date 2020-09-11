import 'package:croosade_4dk/Models/CrusadeCardModel.dart';
import 'package:flutter/material.dart';
import '../utils/Database.dart';
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
        return Scaffold(
          appBar: AppBar(title: Text(cardModel.name),

          ),
          body: CrusadeCardDetailTab(cardModel: cardModel,),
        );
      },
    );
  }

}