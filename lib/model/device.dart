import 'dart:convert';

class Device{
  late String idDev;
  String nameDev;
  double conso;
  dynamic state;
  DateTime dateConso;
  String categorie;
  List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x)=>Device.fromJson(x)));
  String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  Device.fromJson(Map<dynamic, dynamic> json):
    nameDev = json['name'],
    categorie = json['categorie'],
    conso = double.tryParse(json['conso'])!,
    state = json['state'],
    dateConso = json['dateConso'];

  Map<dynamic, dynamic> toJson() => {
    'id':idDev,
    'name': nameDev,
    'categorie':categorie,
    'conso': conso,
    'state' : state,
    'dateConso':dateConso
  };
  
}