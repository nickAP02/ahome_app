import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Device{
  String name = "";
  double conso =0.0;
  dynamic state = [];
  Icon icone = const Icon(Icons.devices);
  Device({required conso, required name, required state,  icone});

  factory Device.fromJson(Map<String, dynamic> json)=>Device(
    name : json['name'],
    conso : json['conso'],
    state : json['state']
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'conso': conso,
    'state' : state
  };
  
}