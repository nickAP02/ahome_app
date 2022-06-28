import 'dart:convert';

class Room {
  List<Room> roomFromJson(String str) => List<Room>.from(json.decode(str).map((x)=>Room.fromJson(x)));
  String roomToJson(List<Room> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  Room( 
    this.idRoom,
    this.nameRoom,
    this.categorie
  );
  
  int idRoom;
  String nameRoom;
  String categorie;
  
 
   Room.fromJson(Map<String, dynamic> json):
    idRoom = json["idRoom"],
    nameRoom = json["nameRoom"],
    categorie = json['categorie'];

  Map<String, dynamic> toJson() => {
    'idRoom': idRoom,
    'name': nameRoom,
    'categorie' : categorie
  };

}