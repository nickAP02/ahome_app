import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:intl/intl.dart';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:json_annotation/json_annotation.dart';
// @JsonSerializable()
class Device{
  late String idDev;
  String nameDev;
  late double puissance;
  double conso;
  dynamic state;
  DateTime dateConso;
  String categorie;
  Room room;
  Device({
    required this.nameDev,
    required this.state,
    required this.puissance,
    required this.conso,
    required this.dateConso,
    required this.categorie,
    required this.room
});
  List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x)=>Device.fromJson(x)));
  String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory Device.fromJson(Map<dynamic, dynamic> json){
    return Device(
      nameDev : json['name']??"",
      categorie : json['categorie']??"",
      puissance: json['puissance']??"",
      conso : double.tryParse(json['conso'])!,
      state : json['state']??"",
      room : json['nameRoom']??"",
      dateConso : DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['dateConso'])
      );
  }
  Map<dynamic, dynamic> toJson() => {
    'name': nameDev,
    // 'conso':conso,
    'categorie':categorie,
    'puissance': puissance,
    'state' : state,
    'dateConso':dateConso.toIso8601String(),
    'nameRoom':room.nameRoom
  };
  
}