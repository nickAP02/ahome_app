import 'dart:convert';
import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/device.dart';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:json_annotation/json_annotation.dart';
// @JsonSerializable()
class Room {
  List<Room> roomFromJson(String str) => List<Room>.from(json.decode(str).map((x)=>Room.fromJson(x)));
  String roomToJson(List<Room> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  String idRoom;
  String nameRoom;
  // double conso;
  List<Device> appareils;
  List<Capteur>? capteurs;
  Room({
      required this.idRoom,
      required this.nameRoom,
      // required this.conso,
      required this.appareils,
      this.capteurs
    });
  
   factory Room.fromJson(Map<String, dynamic> json){
    print("humm room encore "+json.toString());
    var smth= Room(
      
      idRoom: json["id"]??"",
      nameRoom: json["name"]??"",
      // conso: json["conso"]??0,
      appareils :json["appareils"] != null ?List<Device>.from( json["appareils"].map((x)=>
      Device.fromJson(x))):[],
      capteurs: json["capteurs"]!= null ?List<Capteur>.from( json["capteurs"].map((x)=>
      Capteur.fromJson(x))):[]
    );
    return smth;
   }

  Map<String, dynamic> toJson() => {
    'name': nameRoom,
    'appareils':List<Device>.from(appareils.map((x)=>x.toJson())),
    'capteurs': List<Capteur>.from(capteurs!.map((e) => e.toJson()))
  };

}