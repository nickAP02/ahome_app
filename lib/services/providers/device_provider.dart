import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier{
  List<Device>? device = [];
  bool loading = false;
  final HttpService httpService = HttpService();
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
  Future getRoomDevice() async{
    
    notifyListeners();
   
  }
}