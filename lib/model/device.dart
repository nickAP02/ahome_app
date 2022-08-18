import 'dart:convert';
class Device{
  
  String idDev;
  String? nameDev;
  // String? icone;
  double? puissance;
  double? conso;
  List<dynamic> state;
  // List state;
  // DateTime dateConso;
  String? room;
  Device({
     required this.idDev,
     this.nameDev,
    //  this.icone,
     this.puissance,
     this.conso,
     required this.state,
    // required this.dateConso,
     this.room
});

  List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x)=>Device.fromJson(x)));
  String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  
  factory Device.fromJson(Map<String, dynamic> json){
    print("state "+json['state'].toString());
    return Device(
      idDev : json['id'],
      nameDev : json['name']??"",
      // icone : json['icone']??"",
      puissance: json['puissance'].toDouble(),
      conso : json['conso'].toDouble(),
      state : List.from(json['state']),
      room : json['nameRoom']??""
      );
      
  }
  Map<dynamic, dynamic> toJson() => {
    'id':idDev,
    'name': nameDev,
    // 'icone':icone,
    'puissance': puissance,
     'state' : state,
    // 'state' : List.from(state.map((e) => e)),
    // 'dateConso':dateConso.toIso8601String(),
    'nameRoom':room
  };
  
}