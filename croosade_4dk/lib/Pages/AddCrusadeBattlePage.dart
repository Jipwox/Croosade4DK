import 'package:flutter/cupertino.dart';
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
  DateTime selectedDate = DateTime.now();
  Set<int> checkedIds = new Set<int>();
  Map<int,bool> checkedValues = new Map<int,bool>();

  Future<List<CrusadeCardModel>> initRetrieveCardModels() async {
    cardModels = await DatabaseProvider.db.getCrusadeCards(widget.crusadeForceId);

    cardModels.forEach((element) {
      checkedIds.add(element.id);
      checkedValues[element.id] = true;
    });

    return cardModels;
  }

  Future<List<CrusadeCardModel>> retrieveCardModels() async {
    cardModels = await DatabaseProvider.db.getCrusadeCards(widget.crusadeForceId);

    return cardModels;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  @override
  void initState(){
    super.initState();
    initRetrieveCardModels();
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
                            SizedBox(width: 80,),
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Text("Opposing Force "),
                            SizedBox(width: 35,),
                            Container(
                              width: 250.0,
                              child: TextField(
                                decoration: InputDecoration(
                                ),
                                controller: opposingForceNameController,
                              ),
                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Text("Date "),
                            SizedBox(width: 105,),
                            Text("${selectedDate.month}/${selectedDate.day}/${selectedDate.year}"),
                            IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () => _selectDate(context),
                            ),
                          ]
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16.0),
                        itemCount: cardModels.length,
                        itemBuilder: /*1*/ (context, i) {
                          return _buildRow(cardModels[i]);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                            Container(
                              width: 300,
                              child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Battle details / notable events...",
                                  border: OutlineInputBorder(),
                                ),
                                controller: infoController,
                              ),
                            ),
                          ]
                      ),
                      RaisedButton(
                        child: Text("Save"),
                        onPressed: () => {

                        },
                      ),
                    ],
                  )
              );
            }
        )
    );
  }


  Widget _buildRow(CrusadeCardModel cardModel) {
    String title = "${cardModel.name} / PR: ${cardModel.powerRating} / ${cardModel.rank}";
    return CheckboxListTile(
      title: Text(title),
      controlAffinity: ListTileControlAffinity.leading,
      value: checkedValues[cardModel.id],
      onChanged: (bool value){
        print(value);
        setState(() {
          checkedValues[cardModel.id] = value;
          if(value) checkedIds.add(cardModel.id);
          if(!value) checkedIds.remove(cardModel.id);
          print(checkedIds);
        });
      },
    );
  }
}