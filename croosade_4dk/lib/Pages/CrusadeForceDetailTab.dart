import 'package:flutter/material.dart';
import '../Models/CrusadeForceModel.dart';
import '../utils/Database.dart';
import 'package:croosade_4dk/Widgets/ForceDetailScrollView.dart';

class CrusadeForceDetailTab extends StatefulWidget {
  final CrusadeForceModel forceModel;

  CrusadeForceDetailTab({@required this.forceModel});

  @override
  _CrusadeForceDetailTabState createState() => _CrusadeForceDetailTabState();
}

class _CrusadeForceDetailTabState extends State<CrusadeForceDetailTab>  {

  var forceNameController = new TextEditingController();
  var forceFactionController = new TextEditingController();
  var forceInfoController = new TextEditingController();
  var forceSupplyLimitController = new TextEditingController();
  CrusadeForceModel forceModel;
  int crusadePoints;

  @override
  void initState(){
    super.initState();
    retrieveModel();
  }

  void refreshPage(){
    setState(() {
      retrieveModel();
    });
  }

  Future<CrusadeForceModel> retrieveModel() async {
    forceModel = await DatabaseProvider.db.getCrusadeForce(widget.forceModel.id);
    crusadePoints = await DatabaseProvider.db.getCrusadePoints(widget.forceModel.id);
    forceNameController.text = forceModel.name;
    forceFactionController.text = forceModel.faction;
    forceInfoController.text = forceModel.info;
    forceSupplyLimitController.text = forceModel.supplyLimit.toString();
    print("Inside retrieveModel()");
    print("forceModel ID = ${forceModel.id}");

    return forceModel;
  }

  @override
  Widget build(BuildContext context) {
    refreshPage();
    return FutureBuilder(
        future: retrieveModel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState != ConnectionState.done) return new CircularProgressIndicator();
          return ForceDetailScrollView(forceModel: forceModel, forceNameController: forceNameController,
                                       forceFactionController: forceFactionController, forceInfoController: forceInfoController,
                                        crusadePoints: crusadePoints, forceSupplyLimitController: forceSupplyLimitController ,);
        },
    );
  }

}