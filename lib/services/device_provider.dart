import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier{
  List<Device>? device;
   bool loading = false;
  final HttpService httpService = HttpService();
  getRoomData() async{
    loading = true;
    device = await httpService.getDevices();
    loading = false;
    notifyListeners();
  }
  Future<Device> addDevice(Device device) async{
    var res = httpService.addDevice(device);
    notifyListeners();
    return res;
    
  }
  Future<Device> getDevice(String id) async{
    var res = httpService.getDevice(id);
    notifyListeners();
    return res;
  }
}