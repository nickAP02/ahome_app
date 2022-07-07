import 'dart:convert';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:json_annotation/json_annotation.dart';
// @JsonSerializable()
class Room {
  List<Room> roomFromJson(String str) => List<Room>.from(json.decode(str).map((x)=>Room.fromJson(x)));
  String roomToJson(List<Room> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  late String idRoom;
  String nameRoom;
  late Map<String,dynamic> device;
  String capteur;
  Room(
    this.nameRoom,
    this.capteur
  );
  
   factory Room.fromJson(Map<String, dynamic> json){
    return Room(json["name"], json["capteur"]);
   }
    // idRoom = json["idRoom"].toString(),
    // nameRoom = json["nameRoom"]??"",
    // capteur = json["capteur"]?? "",
    // device =  json["appareils"]?? "";

  Map<String, dynamic> toJson() => {
    'name': nameRoom,
    'capteur':capteur
  };

}