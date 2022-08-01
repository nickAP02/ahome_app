import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier{
  List<Device>? device = [];
  List<Device> noNamedDevices = [];
  List<Device> namedDevices = [];
  bool loading = false;
  final HttpService httpService = HttpService();
  List<Device>getNoNamedDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return noNamedDevices;
  }
  setNoNamedDevice(){
    if(device!=null){
       noNamedDevices = device!.where((element) => element.nameDev!.isEmpty).toList();
    }
    else{
      Text("Pas d'appareils disponibles");
    }
    notifyListeners();
  }
   List<Device>getNamedDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return namedDevices;
    
  }
  setNamedDevice(){
    if(device!=null){
       namedDevices = device!.where((element) => element.nameDev!.isNotEmpty).toList();
    }
    else{
      Text("Pas d'appareils disponibles");
    }
    notifyListeners();
  }
  Future getDeviceData() async{
    loading = true;
    device = await httpService.getDevices();
    loading = false;
    notifyListeners();
    return device;
  }
  Future addDevice(Device device) async{
    httpService.addDevice(device);
    notifyListeners();
  }
  
}