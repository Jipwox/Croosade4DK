import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardPowerRatingRow extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CardPowerRatingRow({@required this.cardModel});

  @override
  _CardPowerRatingRowState createState() => _CardPowerRatingRowState();
}

class _CardPowerRatingRowState extends State<CardPowerRatingRow>{


  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
          Text("Power Rating"),
          SizedBox(width: 95,),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.powerRating --;
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
            child: Text(widget.cardModel.powerRating.toString()),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.powerRating ++;
                DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
              });
            },
          ),
        ]
    );
  }
}