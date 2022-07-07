import 'dart:convert';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:json_annotation/json_annotation.dart';
// @JsonSerializable()
class Device{
  late String idDev;
  String nameDev;
  double conso;
  dynamic state;
  DateTime dateConso;
  String categorie;
  Device(
    this.nameDev,
    this.conso,
    this.state,
    this.dateConso,
    this.categorie
  );
  List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x)=>Device.fromJson(x)));
  String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  Device.fromJson(Map<dynamic, dynamic> json):
    nameDev = json['name'],
    categorie = json['categorie'],
    conso = double.tryParse(json['conso'])!,
    state = json['state'],
    dateConso = json['dateConso'];

  Map<dynamic, dynamic> toJson() => {
    'name': nameDev,
    'categorie':categorie,
    'conso': conso,
    'state' : state,
    'dateConso':dateConso.toIso8601String()
  };
  
}