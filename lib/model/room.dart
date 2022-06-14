class Room{
  String idRoom = "";
  String name = "";
  double conso = 0.0;

  Room(this.idRoom, this.name, this.conso);

  Room.fromJson(Map<String, dynamic> json):
    idRoom = json['id'] as String,
    name = json['name'] as String,
    conso = json['appareils']['conso'] as dynamic;


  Map<String, dynamic> toJson() => {
    'id': idRoom,
    'name': name,
    'conso' : conso
  };
}