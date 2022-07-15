import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends ChangeNotifier{
  List<Room>? room=[];
  List<Device> devices=[];
  bool loading = false;
  final HttpService httpService = HttpService();
  Future getRoomData() async{
    loading = true;
    room = await httpService.getRooms();
    loading = false;
    notifyListeners();
    return room;
  }
  Future addRoom(Room room) async{
    debugPrint("ok");
    httpService.addRoom(room);
    notifyListeners();
  }
  Future getRoomDevice(String name) async{
    loading = true;
    devices= await httpService.getRoomDevice(name);
    loading = false;
    notifyListeners();
    return devices;
  }
}