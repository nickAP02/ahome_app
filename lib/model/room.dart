class Room{
  // String idRoom = "";
  String name = "";
  // double conso = 0.0;
  List categorie = [];
  // Room(this.idRoom, this.name, this.conso,this.categorie);
  Room({required categorie, required name});
  factory Room.fromJson(Map<String, dynamic> json)=>Room(
    //idRoom = json['id'] as String,
    name : json["name"],
    // conso = json['appareils']['conso'] as dynamic,
    categorie : json['categorie']);

  Map<String, dynamic> toJson() => {
    // 'id': idRoom,
    'name': name,
    // 'conso' : conso,
    'categorie' : categorie
  };
}