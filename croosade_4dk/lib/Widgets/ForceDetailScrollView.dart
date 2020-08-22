import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';

class ForceDetailScrollView extends StatefulWidget {
  final CrusadeForceModel forceModel;
  var forceNameController = new TextEditingController();
  var forceFactionController = new TextEditingController();
  var forceInfoController = new TextEditingController();

  ForceDetailScrollView({@required this.forceModel, @required this.forceNameController,
                         @required this.forceFactionController, @required this.forceInfoController});

  @override
  _ForceDetailScrollViewState createState() => _ForceDetailScrollViewState();
}

class _ForceDetailScrollViewState extends State<ForceDetailScrollView> {

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
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
                      controller: widget.forceNameController,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Choose your Crusade faction"
                      ),
                      controller: widget.forceFactionController,
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
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.forceModel.battleTally <= 0) return;
                      widget.forceModel.battleTally --;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.forceModel.battleTally.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.forceModel.battleTally ++;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
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
                  child: Text(widget.forceModel.battlesWon.toString()),
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
                  child: Text(widget.forceModel.requisitionPoints.toString()),
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
                  child: Text(widget.forceModel.supplyLimit.toString()),
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
                  child: Text(widget.forceModel.supplyUsed.toString()),
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
                    controller: widget.forceInfoController,
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}