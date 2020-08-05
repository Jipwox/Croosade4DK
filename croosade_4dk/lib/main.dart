import 'package:flutter/material.dart';
import 'home.dart';
import 'AddCrusadeForcePage.dart';

void main() {
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


