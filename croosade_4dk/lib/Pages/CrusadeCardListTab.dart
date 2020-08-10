import 'package:croosade_4dk/Pages/AddCrusadeCardPage.dart';
import 'package:croosade_4dk/Pages/CrusadeForceDetailTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../Models/CrusadeCardModel.dart';
import '../utils/Database.dart';

class CrusadeCardListTab extends StatefulWidget {
  final CrusadeForceModel forceModel;

  CrusadeCardListTab({@required this.forceModel});

  @override
  _CrusadeCardListTabState createState() => _CrusadeCardListTabState();
}

class _CrusadeCardListTabState extends State<CrusadeCardListTab> {

  List<CrusadeCardModel> cardModels = [];

  @override
  void initState(){
    super.initState();
    retrieveCardModels();
  }

  void refreshPage(){
    setState(() {
      retrieveCardModels();
    });
  }

  Future<List<CrusadeCardModel>> retrieveCardModels() async {
    cardModels = await DatabaseProvider.db.getCrusadeCards(widget.forceModel.id);

    return cardModels;
  }

  void _navigateToViewCrusadeCardPage(BuildContext context, cardId) async{
    print("tapped the card row");
    refreshPage();
  }

  void _navigateToAddCrusadeCardPage(int forceId) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddCrusadeCardPage(crusadeforceId: forceId)
        )
    );

    refreshPage();
  }

  @override
  Widget build(BuildContext context){
    refreshPage();
    return Scaffold(
      body: FutureBuilder(
          future: retrieveCardModels(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
            return ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemCount: cardModels.length,
              itemBuilder: /*1*/ (context, i) {
                return _buildRow(cardModels[i]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddCrusadeCardPage(widget.forceModel.id),
        tooltip: 'Add Crusade Force',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRow(CrusadeCardModel cardModel) {
    String title = "${cardModel.name} / ${cardModel.powerRating}";
    return ListTile(
      title: Text(title),             // ... to here.
      onTap: () {
        _navigateToViewCrusadeCardPage(context, cardModel.id);
      },
    );
  }
}