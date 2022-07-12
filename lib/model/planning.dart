import 'dart:convert';

import 'package:ago_ahome_app/model/device.dart';

class Planning{
  List<Planning> planningFromJson(String str) => List<Planning>.from(json.decode(str).map((x)=>Planning.fromJson(x)));
  String planningToJson(List<Planning> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  late String idPlan;
  late String nomPlan;
  late DateTime dateDebut;
  late DateTime dateFin;
  List<Device> appareils;
  Map<String,dynamic> user;
    Planning.fromJson(Map<String,dynamic> json):
      idPlan = json["idPlan"],
      nomPlan = json["nomPlan"],
      dateDebut = json["dateDebut"],
      dateFin = json["dateFin"],
      user =  json["user"],
      appareils = json["appareils"]
      ;

    Map<String,dynamic> toJson()=>{
      'nomPlan':nomPlan,
      'dateDebut':dateDebut,
      'dateFin':dateFin,
      'user' : user
    };
}