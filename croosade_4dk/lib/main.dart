import 'package:flutter/material.dart';
import 'Pages/home.dart';
import 'Pages/AddCrusadeForcePage.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Croosade 4DK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Croosade 4DK'),
      routes: <String, WidgetBuilder> {
        '/AddCrusadeForcePage': (BuildContext context) => AddCrusadeForcePage(),
      },
    );
  }
}


