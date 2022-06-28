import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Device{
  int idDev;
  String nameDev;
  double conso;
  dynamic state;
  DateTime dateConso =  DateTime.now();
  //Icon icone = const Icon(Icons.devices);
  Device(
    this.idDev,
    this.nameDev,
    this.conso,
    this.state,
    this.dateConso
  );

  Device.fromJson(Map<dynamic, dynamic> json):
    idDev = int.tryParse(json['id'])!,
    nameDev = json['name'],
    conso = double.tryParse(json['conso'])!,
    state = json['state'],
    dateConso = json['dateConso'];

  Map<dynamic, dynamic> toJson() => {
    'id':idDev,
    'name': nameDev,
    'conso': conso,
    'state' : state,
    'dateConso':dateConso
  };
  
}