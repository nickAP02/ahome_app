import 'dart:convert';

class Room {
  List<Room> roomFromJson(String str) => List<Room>.from(json.decode(str).map((x)=>Room.fromJson(x)));
  String roomToJson(List<Room> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  late String idRoom;
  String nameRoom;
  late Map<String,dynamic> device;
  String capteur;
  Room(
    this.nameRoom,
    this.capteur
  );
  
   Room.fromJson(Map<String, dynamic> json):
    idRoom = json["idRoom"],
    nameRoom = json["nameRoom"],
    capteur = json["capteur"],
    device =  json["appareils"];

  Map<String, dynamic> toJson() => {
    'name': nameRoom,
    'capteur':capteur
  };

}