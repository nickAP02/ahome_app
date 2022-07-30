import 'dart:convert';

import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/cupertino.dart';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:json_annotation/json_annotation.dart';
// @JsonSerializable()
class Room {
  List<Room> roomFromJson(String str) => List<Room>.from(json.decode(str).map((x)=>Room.fromJson(x)));
  String roomToJson(List<Room> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  String idRoom;
  String nameRoom;
  List<Device> appareils;
  Room({
      required this.idRoom,
      required this.nameRoom,
      required this.appareils
    });
  
   factory Room.fromJson(Map<String, dynamic> json){

    var r= Room(
      idRoom: json["id"]??"",
      nameRoom: json["name"]??"",
      appareils :json["appareils"] !=null ?List<Device>.from( json["appareils"].map((x)=>
  Device.fromJson(x)
     
      )):[]
    );

return r;
   }

  Map<String, dynamic> toJson() => {
    'name': nameRoom,
    'appareils':List<Device>.from(appareils.map((x)=>x.toJson()))
  };

}