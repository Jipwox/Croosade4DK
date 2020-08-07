import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'CrusadeForceModel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class CrusadeForceModel{

  String name;
  String faction;
  int battleTally;
  int battlesWon;
  int requisitionPoints;
  int supplyLimit;
  int supplyUsed;

  CrusadeForceModel(String name, String faction){
    this.name = name;
    this.faction = faction;
    this.battleTally = 0;
    this.battlesWon = 0;
    this.requisitionPoints = 5;
    this.supplyLimit = 50;
    this.supplyUsed = 0;
  }

  /// A necessary factory constructor for creating a new CrusadeForceModel instance
  /// from a map. Pass the map to the generated `_$CrusadeForceModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, CrusadeForceModel.
  factory CrusadeForceModel.fromJson(Map<String, dynamic> json) => _$CrusadeForceModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CrusadeForceModelToJson`.
  Map<String, dynamic> toJson() => _$CrusadeForceModelToJson(this);
}