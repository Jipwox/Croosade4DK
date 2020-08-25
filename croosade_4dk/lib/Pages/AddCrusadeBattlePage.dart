import 'package:flutter/material.dart';
import '../Models/CrusadeBattleModel.dart';
import '../Models/CrusadeCardModel.dart';
import '../utils/Database.dart';

class AddCrusadeBattlePage extends StatefulWidget {
  final String title = "New Battle!";
  final int crusadeForceId;

  AddCrusadeBattlePage({@required this.crusadeForceId});

  @override
  _AddCrusadeBattleState createState() => _AddCrusadeBattleState();
}

class _AddCrusadeBattleState extends State<AddCrusadeBattlePage>{
  TextEditingController battleNameController = new TextEditingController();
  TextEditingController opposingForceNameController = new TextEditingController();
  TextEditingController infoController = new TextEditingController();
  TextEditingController date = new TextEditingController();
  List<CrusadeCardModel> cardModels = new List<CrusadeCardModel>();

  Future<List<CrusadeCardModel>> retrieveCardModels() async {
    cardModels = await DatabaseProvider.db.getCrusadeCards(widget.crusadeForceId);

    return cardModels;
  }

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

  @override
  Widget build(BuildContext context) {
    refreshPage();
    return Scaffold(
        appBar: AppBar(title: Text(widget.title),),
        body: FutureBuilder(
            future: retrieveCardModels(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20.0),),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Text("Battle of "),
                            SizedBox(width: 40,),
                            Container(
                              width: 250.0,
                              child: TextField(
                                decoration: InputDecoration(
                                ),
                                controller: battleNameController,
                              ),
                            ),
                          ]
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: new NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.0),
                        itemCount: cardModels.length,
                        itemBuilder: /*1*/ (context, i) {
                          return _buildRow(cardModels[i]);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },)
                    ],
                  )
              );
            }
        )
    );
  }


  Widget _buildRow(CrusadeCardModel cardModel) {
    String title = "${cardModel.name} / PR: ${cardModel.powerRating} / ${cardModel.rank}";
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
        //_navigateToViewCrusadeCardPage(context, cardModel.id);
      },
    );
  }
}