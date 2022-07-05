import 'dart:convert';

class Planning{
  List<Planning> planningFromJson(String str) => List<Planning>.from(json.decode(str).map((x)=>Planning.fromJson(x)));
  String planningToJson(List<Planning> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  late String idPlan;
  late String nomPlan;
  late DateTime dateDebut;
  late DateTime dateFin;

  Map<String,dynamic> user;
    Planning.fromJson(Map<String,dynamic> json):
      idPlan = json["idPlan"],
      nomPlan = json["nomPlan"],
      dateDebut = json["dateDebut"],
      dateFin = json["dateFin"],
      user =  json["user"];

    Map<String,dynamic> toJson()=>{
      'nomPlan':nomPlan,
      'dateDebut':dateDebut,
      'dateFin':dateFin,
      'user' : user
    };
}