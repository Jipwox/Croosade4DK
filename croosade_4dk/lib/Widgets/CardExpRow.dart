import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardExpRow extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CardExpRow({@required this.cardModel});

  @override
  _CardExpRowState createState() => _CardExpRowState();
}

class _CardExpRowState extends State<CardExpRow>{

  int getExp(){
    return widget.cardModel.experiencePoints;
  }

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
          Text("Experience Points"),
          SizedBox(width: 95,),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.experiencePoints --;
              });
            },
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(widget.cardModel.experiencePoints.toString()),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.experiencePoints ++;
                DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
              });
            },
          ),
        ]
    );
  }
}