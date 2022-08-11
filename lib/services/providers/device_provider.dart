import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier{
  List<Device>? device = [];
  List<Device> noNamedDevices = [];
  List<Device> namedDevices = [];
  dynamic newDevice;
  bool loading = false;
  final HttpService httpService = HttpService();
  List<Device>getNoNamedDevices(){
    // loading = true;
    notifyListeners();
    // loading = false;
    return noNamedDevices;
  }
  setNoNamedDevice(){
    debugPrint("liste vide device " +device.toString());
    if(device!=null){
      noNamedDevices = device!.where((element) => element.nameDev!.isEmpty&&element.room!.isEmpty).toList();
      notifyListeners();
      debugPrint("liste  nonamedDevices " +noNamedDevices.toList().toString());
      // noNamedDevices.forEach((element) {debugPrint(element.nameDev);});
    }
    else{
     debugPrint("liste vide noNamedDevices " +noNamedDevices.toList().toString());
    }
    notifyListeners();
  }
   List<Device>getNamedDevices(){
    // loading = true;
    notifyListeners();
    // loading = false;
    return namedDevices;
    
  }
  setNamedDevice(){
    if(device!=null){
       namedDevices = device!.where((element) => element.nameDev!.isNotEmpty&&element.room!.isEmpty).toList();
       debugPrint("liste namedDevices " +namedDevices.toList().toString());
       notifyListeners();
      //  namedDevices.forEach((element) {debugPrint(element.nameDev);});
    }
    else{
      debugPrint("liste vide namedDevices " +namedDevices.toList().toString());
    }
    notifyListeners();
  }
  Future getDeviceData() async{
    loading = true;
    device = await httpService.getDevices();
    debugPrint("value "+device.toString());
    loading = false;
    notifyListeners();
    return device;
  }
  Future addDevice(Device device) async{
    httpService.addDevice(device);
    notifyListeners();
  }

  Future updateDevice(Device device) async{
    httpService.updateDevice(device);
    notifyListeners();
  }

  Future deleteDevice(Device device) async{
    httpService.deleteDevice(device);
    notifyListeners();
  }
}