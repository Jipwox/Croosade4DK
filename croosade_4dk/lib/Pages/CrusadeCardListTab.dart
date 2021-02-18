import 'package:croosade_4dk/Pages/AddCrusadeCardPage.dart';
import 'package:croosade_4dk/Pages/ViewCrusadeCardPage.dart';
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
  var forcePower = 0;
  var forceCrusadePoints = 0;

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
    forcePower = 0;
    forceCrusadePoints = 0;
    cardModels.forEach((element) {
      forcePower += element.powerRating;
      forceCrusadePoints += element.crusadePoints;
    });

    return cardModels;
  }

  void _navigateToViewCrusadeCardPage(BuildContext context, cardId) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewCrusadeCardPage(cardId: cardId,)
        )
    );
    refreshPage();
  }

  void _navigateToAddCrusadeCardPage(int forceId) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddCrusadeCardPage(crusadeForceId: forceId)
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
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Total Power: " + forcePower.toString() + "   Crusade Points: " + forceCrusadePoints.toString()),
                Expanded(
                    child: ListView.separated(
                              padding: EdgeInsets.all(16.0),
                              itemCount: cardModels.length,
                              itemBuilder: /*1*/ (context, i) {
                                return _buildRow(cardModels[i]);
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },)
                ),
              ],
            );
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
    String title = "${cardModel.name} / PR: ${cardModel.powerRating} / CP: ${cardModel.crusadePoints} / ${cardModel.rank}";
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
                        DatabaseProvider.db.deleteCrusadeCardModel(cardModel.id, cardModel.crusadeForceId);
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
        _navigateToViewCrusadeCardPage(context, cardModel.id);
      },
    );
  }
}