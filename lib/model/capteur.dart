import 'dart:convert';
class Capteur{
  String id;
  String nameRoom;
  List state;
  Capteur(
    this.id,
    this.nameRoom,
    this.state
  );
  List<Capteur> deviceFromJson(String str) => List<Capteur>.from(json.decode(str).map((x)=>Capteur.fromJson(x)));
  String deviceToJson(List<Capteur> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory Capteur.fromJson(Map<dynamic, dynamic> json){
    return Capteur(
      json['id'],
      json['nameRoom'],
      List.from(json['state'])
    );
  }
  Map<dynamic, dynamic> toJson() => {
    'id':id,
    'nameRoom': nameRoom,
    'state' : List.from(state.map((e) => e))
  };
}