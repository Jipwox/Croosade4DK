import 'package:flutter/material.dart';

class AddCrusadeForcePage extends StatefulWidget {

  final String title = "New Crusade Force";

  @override
  _AddCrusadeForceState createState() => _AddCrusadeForceState();
}

class _AddCrusadeForceState extends State<AddCrusadeForcePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text("This is the AddCrusadeForcePage") // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
