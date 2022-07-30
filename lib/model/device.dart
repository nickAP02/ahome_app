import 'dart:convert';
class Device{
  String idDev;
  String? nameDev;
  String? categorie;
  double? puissance;
  double? conso;
  List<dynamic> state;
  // List state;
  // DateTime dateConso;
  String? room;
  Device({
     required this.idDev,
     this.nameDev,
     this.categorie,
     this.puissance,
     this.conso,
     required this.state,
    // required this.dateConso,
     this.room
});
  List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x)=>Device.fromJson(x)));
  String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory Device.fromJson(Map<String, dynamic> json){
    
    return Device(
      idDev : json['id'],
      nameDev : json['name'],
      categorie : json['categorie'],
      puissance: json['puissance'].toDouble(),
      conso : json['conso'].toDouble(),
      state : json['state'],
      // state : List.from(json['state']),
      // dateConso : DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['dateConso'])
      room : json['nameRoom'],
      );
  }
  Map<dynamic, dynamic> toJson() => {
    'id':idDev,
    'name': nameDev,
    'categorie':categorie,
    'puissance': puissance,
     'state' : state,
    // 'state' : List.from(state.map((e) => e)),
    // 'dateConso':dateConso.toIso8601String(),
    'nameRoom':room
  };
  
}