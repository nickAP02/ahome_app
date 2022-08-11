import 'dart:convert';
class Capteur{
  List<Capteur> capteurFromJson(String str) => List<Capteur>.from(json.decode(str).map((x)=>Capteur.fromJson(x)));
  String capteurToJson(List<Capteur> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  String id;
  String nameRoom;
  List state;
  Capteur({
    required this.id,
    required this.nameRoom,
    required this.state
  });
  
  factory Capteur.fromJson(Map<dynamic, dynamic> json){
    return Capteur(
      id:json['id'],
      nameRoom:json['nameRoom'],
      state:List.from(json['state'])
    );
  }
  Map<dynamic, dynamic> toJson() => {
    'nameRoom': nameRoom,
    'capteurs' : List<Capteur>.from(state.map((e) => e.toJson()))
  };
}