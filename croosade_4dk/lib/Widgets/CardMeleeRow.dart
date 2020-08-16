import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardMeleeRow extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CardMeleeRow({@required this.cardModel});

  @override
  _CardMeleeRowState createState() => _CardMeleeRowState();
}

class _CardMeleeRowState extends State<CardMeleeRow>{

  int getTotalDestroyedMelee(){
    return widget.cardModel.totalDestroyedMelee;
  }

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
          Text("Total Destroyed w/ Melee"),
          SizedBox(width: 45,),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.totalDestroyedMelee --;
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
            child: Text(widget.cardModel.totalDestroyedMelee.toString()),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                widget.cardModel.totalDestroyedMelee ++;
                DatabaseProvider.db.updateCrusadeCardModel(widget.cardModel);
              });
            },
          ),
        ]
    );
  }
}