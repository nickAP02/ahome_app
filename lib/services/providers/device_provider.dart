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
    debugPrint("liste device " +device.toString());
    if(device!=null){
      noNamedDevices = device!.where((element) => element.nameDev!.isEmpty).toList();
      notifyListeners();
      debugPrint("liste  nonamedDevices " +noNamedDevices.toString());
      // noNamedDevices.forEach((element) {debugPrint(element.nameDev);});
    }
    else{
     debugPrint("liste vide noNamedDevices " +noNamedDevices.toString());
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
       namedDevices = device!.where((element) => element.nameDev!.isNotEmpty).toList();
       debugPrint("liste namedDevices " +namedDevices.toString());
       notifyListeners();
      //  namedDevices.forEach((element) {debugPrint(element.nameDev);});
    }
    else{
      debugPrint("liste vide namedDevices " +namedDevices.toString());
    }
    notifyListeners();
  }
  Future getDeviceData() async{
    loading = true;
    device = await httpService.getDevices().then((value) => device=value);
    debugPrint("value "+device.toString());
    loading = false;
    notifyListeners();
    return device;
  }
  Future<dynamic> addDevice(Device device) async{
    var result = httpService.addDevice(device);
    notifyListeners();
    return result;
  }

  Future updateDevice(Device device) async{
    httpService.updateDevice(device);
    notifyListeners();
  }

  Future<dynamic> deleteDevice(String id) async{
    httpService.deleteDevice(id);
    notifyListeners();
  }
}