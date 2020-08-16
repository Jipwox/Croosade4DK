import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardBattlesPlayedRow extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CardBattlesPlayedRow({@required this.cardModel});

  @override
  _CardBattlesPlayedRowState createState() => _CardBattlesPlayedRowState();
}

class _CardBattlesPlayedRowState extends State<CardBattlesPlayedRow>{


  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
          Text("Battles Played"),
          SizedBox(width: 95,),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.battlesPlayed --;
                DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
              });
            },
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(widget.cardModel.battlesPlayed.toString()),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.battlesPlayed ++;
                DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
              });
            },
          ),
        ]
    );
  }
}