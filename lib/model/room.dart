import 'dart:convert';

class Room {
  List<Room> roomFromJson(String str) => List<Room>.from(json.decode(str).map((x)=>Room.fromJson(x)));
  String roomToJson(List<Room> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  int idRoom;
  String nameRoom;
  Map<String,dynamic> device;
 
  
  
   Room.fromJson(Map<String, dynamic> json):
    idRoom = json["idRoom"],
    nameRoom = json["nameRoom"],
    device =  json["appareils"];

  Map<String, dynamic> toJson() => {
    'idRoom': idRoom,
    'name': nameRoom,
    'appareils' : device
  };

}