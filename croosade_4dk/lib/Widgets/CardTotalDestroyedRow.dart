import '../utils/Database.dart';
import 'package:flutter/material.dart';
import '../Models/CrusadeCardModel.dart';
import 'package:croosade_4dk/utils/Database.dart';

class CardTotalDestroyedRow extends StatefulWidget {
  final CrusadeCardModel cardModel;

  CardTotalDestroyedRow({@required this.cardModel});

  @override
  _CardTotalDestroyedRowState createState() => _CardTotalDestroyedRowState();
}

class _CardTotalDestroyedRowState extends State<CardTotalDestroyedRow>{

  int getTotalDestroyed(){
    return widget.cardModel.totalDestroyed;
  }

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
          Text("Total Destroyed"),
          SizedBox(width: 45,),
          Container(
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(widget.cardModel.totalDestroyed.toString()),
          ),
        ]
    );
  }
}