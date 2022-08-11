import 'dart:convert';

import 'package:ago_ahome_app/model/device.dart';

class Planning{
 
  String ?idPlan;
  String nomPlan;
  String dateDebut;
  String dateFin;
  List<dynamic> appareils;
  dynamic job;
  Planning({
    this.idPlan,
    required this.nomPlan,
    required this.dateDebut,
    required this.dateFin,
    required this.appareils,
    this.job
  });
   List<Planning> planningFromJson(String str) => List<Planning>.from(json.decode(str).map((x)=>Planning.fromJson(x)));
  String planningToJson(List<Planning> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  
  factory Planning.fromJson(Map<String,dynamic> json){
    // print("viens tu ici ?");
    // print("le resultat "+json.toString());
    return Planning(
      idPlan: json["idPlan"],
      nomPlan: json["nomPlan"],
      dateDebut : json["dateDebut"],
      dateFin : json["dateFin"],
      appareils : json["appareils"],
      job: json["job"]
    );
  }

    Map<String,dynamic> toJson()=>{
      'nomPlan':nomPlan,
      'dateDebut':dateDebut,
      'dateFin':dateFin,
      'appareils' : appareils
    };
}