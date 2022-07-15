import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:intl/intl.dart';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:json_annotation/json_annotation.dart';
// @JsonSerializable()
class Device{
  String idDev;
  String? nameDev;
  String? categorie;
  double puissance;
  double conso;
  List state;
  // DateTime dateConso;
  String? room;
  Device({
    required this.idDev,
    required this.nameDev,
    required this.categorie,
    required this.puissance,
    required this.conso,
    required this.state,
    // required this.dateConso,
    required this.room
});
  List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x)=>Device.fromJson(x)));
  String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory Device.fromJson(Map<dynamic, dynamic> json){
    return Device(
      idDev : json['id'],
      nameDev : json['name'],
      categorie : json['categorie'],
      puissance: json['puissance'].toDouble(),
      conso : json['conso'].toDouble(),
      state : List.from(json['state']),
      // dateConso : DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['dateConso'])
      room : json['nameRoom'],
      );
  }
  Map<dynamic, dynamic> toJson() => {
    'id':idDev,
    'name': nameDev,
    'categorie':categorie,
    'puissance': puissance,
    'state' : List.from(state.map((e) => e)),
    // 'dateConso':dateConso.toIso8601String(),
    'nameRoom':room
  };
  
}