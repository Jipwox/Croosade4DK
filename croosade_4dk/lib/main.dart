import 'package:flutter/material.dart';
import 'Pages/home.dart';
import 'Pages/AddCrusadeForcePage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Croosade40K',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Croosade40K'),
      routes: <String, WidgetBuilder> {
        '/AddCrusadeForcePage': (BuildContext context) => AddCrusadeForcePage(),
      },
    );
  }
}


