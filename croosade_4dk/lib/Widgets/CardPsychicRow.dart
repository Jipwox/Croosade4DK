import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardPsychicRow extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CardPsychicRow({@required this.cardModel});

  @override
  _CardPsychicRowState createState() => _CardPsychicRowState();
}

class _CardPsychicRowState extends State<CardPsychicRow>{


  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
          Text("Total Destroyed w/ Psychic"),
          SizedBox(width: 45,),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.totalDestroyedPsychic --;
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
            child: Text(widget.cardModel.totalDestroyedPsychic.toString()),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.totalDestroyedPsychic ++;
                DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
              });
            },
          ),
        ]
    );
  }
}