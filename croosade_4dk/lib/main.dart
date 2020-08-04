import 'package:flutter/material.dart';

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
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _forceList = <String>[];

  void _nootPrinter(){
    print("Noot Noot, Motherfucker");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _crusadeForceList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _nootPrinter,
        tooltip: 'Add Crusade Force',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _crusadeForceList() {
    _forceList.add("Vibing Dragons");
    _forceList.add("Blue Suits");
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _forceList.length,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          return _buildRow(_forceList[index]);
        });
  }

  Widget _buildRow(String forceName) {
    return ListTile(
      title: Text(forceName),             // ... to here.
      onTap: () {print("Force: $forceName was clicked");},
    );
  }
}
