import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';

class ViewCrusadeForcePage extends StatefulWidget {
  final String title;
  final int id;
  ViewCrusadeForcePage({@required this.title, @required this.id});

  @override
  _ViewCrusadeForceState createState() => _ViewCrusadeForceState();
}

class _ViewCrusadeForceState extends State<ViewCrusadeForcePage> {

  var forceNameController = new TextEditingController();
  var forceFactionController = new TextEditingController();
  var forceInfoController = new TextEditingController();
  CrusadeForceModel forceModel;

  @override
  void initState(){
    super.initState();
    retrieveModel();
  }


  Future<CrusadeForceModel> retrieveModel() async {
    forceModel = await DatabaseProvider.db.getCrusadeForce(widget.id);
    forceNameController.text = forceModel.name;
    forceFactionController.text = forceModel.faction;
    forceInfoController.text = forceModel.info;

    return forceModel;
  }

  void refreshPage(){
    setState(() {
      retrieveModel();
    });
  }

  void updateForceModel(CrusadeForceModel crusadeForceModel) async {
    crusadeForceModel.name = forceNameController.text;
    crusadeForceModel.faction = forceFactionController.text;
    crusadeForceModel.info = forceInfoController.text;
    await DatabaseProvider.db.updateCrusaderForceModel(crusadeForceModel);

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
          appBar: AppBar(title: Text(widget.title),),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20.0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10.0,),),
                          Text("Force Name"),
                          SizedBox(height: 30,),
                          Text("Force Faction"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10.0,),),
                          Container(
                            width: 250.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Name your Crusade force"
                              ),
                              controller: forceNameController,
                            ),
                          ),
                          Container(
                            width: 250.0,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Choose your Crusade faction"
                              ),
                              controller: forceFactionController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Text("Battle Tally"),
                        SizedBox(width: 100,),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          child: Text(forceModel.battleTally.toString()),
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Text("Battles Won"),
                        SizedBox(width: 95,),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: Text(forceModel.battlesWon.toString()),
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Text("Requisition Points"),
                        SizedBox(width: 57,),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: Text(forceModel.requisitionPoints.toString()),
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Text("Supply Limit"),
                        SizedBox(width: 93,),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: Text(forceModel.supplyLimit.toString()),
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Text("Supply Used"),
                        SizedBox(width: 94,),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: Text(forceModel.supplyUsed.toString()),
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                        Container(
                          width: 300,
                          child: TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: "Crusade Goals, Info, and Notable Victories/Defeats go here...",
                                border: OutlineInputBorder(),
                            ),
                            controller: forceInfoController,
                          ),
                        ),
                      ]
                  ),
                  RaisedButton(
                      child: Text("Save"),
                      onPressed: (){
                        updateForceModel(forceModel);
                      }
                  ),
                ],
              ),
            ),
          ),// This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}