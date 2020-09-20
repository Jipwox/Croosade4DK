import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ForceDetailScrollView extends StatefulWidget {
  final CrusadeForceModel forceModel;
  var forceNameController = new TextEditingController();
  var forceFactionController = new TextEditingController();
  var forceInfoController = new TextEditingController();
  int crusadePoints = 0;

  ForceDetailScrollView({@required this.forceModel, @required this.forceNameController,
                         @required this.forceFactionController, @required this.forceInfoController,
                         @required this.crusadePoints});

  @override
  _ForceDetailScrollViewState createState() => _ForceDetailScrollViewState();
}

class _ForceDetailScrollViewState extends State<ForceDetailScrollView> {

  String _imageFilePath;
  PickedFile _imageFile;
  ImagePicker imagePicker = new ImagePicker();
  MediaQueryData queryData;


  Future getImage() async{
    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
      _imageFilePath = _imageFile.path;
      widget.forceModel.imagePath = _imageFilePath;
      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
    });
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    widget.forceNameController.addListener(_updateFromControllers);
    widget.forceFactionController.addListener(_updateFromControllers);
    widget.forceInfoController.addListener(_updateFromControllers);

    _imageFilePath = widget.forceModel.imagePath;
  }

  @override
  void dispose(){
    widget.forceNameController.dispose();
    widget.forceFactionController.dispose();
    widget.forceInfoController.dispose();
    super.dispose();
  }

  _updateFromControllers(){
    widget.forceModel.name = widget.forceNameController.text;
    widget.forceModel.faction = widget.forceFactionController.text;
    widget.forceModel.info =  widget.forceInfoController.text;

    DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
  }

  @override
  Widget build(BuildContext context){
    queryData = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20.0),),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Container(
                  width: 250.0,
                  child: _imageFilePath != "" ? GestureDetector(
                      child: Container(
                        child: Image.file(File(_imageFilePath)),
                      ),
                      onTap:(){
                        getImage();
                      }
                  ): RaisedButton(
                    child: Text("Upload Image"),
                    onPressed: getImage,
                  ),
                ),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0,),),
                  Text("Force Name"),
                  SizedBox(height: 33,),
                  Text("Force Faction"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0,),),
                  Container(
                    width: 250.0,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Name your Crusade force"
                      ),
                      controller: widget.forceNameController,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Choose your Crusade faction"
                      ),
                      controller: widget.forceFactionController,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Battle Tally"),
                SizedBox(width: queryData.size.width/4.815,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.forceModel.battleTally <= 0) return;
                      widget.forceModel.battleTally --;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.forceModel.battleTally.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.forceModel.battleTally ++;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Battles Won"),
                SizedBox(width: queryData.size.width/5.15,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.forceModel.battlesWon <= 0) return;
                      widget.forceModel.battlesWon --;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.forceModel.battlesWon.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.forceModel.battlesWon ++;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Requisition Points"),
                SizedBox(width: queryData.size.width/9.85,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.forceModel.requisitionPoints <= 0) return;
                      widget.forceModel.requisitionPoints --;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.forceModel.requisitionPoints.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.forceModel.requisitionPoints ++;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Crusade Points"),
                SizedBox(width: queryData.size.width/3.8,),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.crusadePoints.toString()),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Supply Limit"),
                SizedBox(width: queryData.size.width/5.25,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(widget.forceModel.supplyLimit <= 0) return;
                      widget.forceModel.supplyLimit --;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.forceModel.supplyLimit.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.forceModel.supplyLimit ++;
                      DatabaseProvider.db.updateCrusadeForceModel(widget.forceModel);
                    });
                  },
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Text("Supply Used"),
                SizedBox(width: queryData.size.width/3.245,),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.forceModel.supplyUsed.toString()),
                )
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0),),
                Container(
                  width: 300,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Crusade Goals, Info, and Notable Victories/Defeats go here...",
                      border: OutlineInputBorder(),
                    ),
                    controller: widget.forceInfoController,
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}