import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends ChangeNotifier{
  List<Room>? room;
  bool loading = false;
  final HttpService httpService = HttpService();
  Future getRoomData() async{
    loading = true;
    room = await httpService.getRooms();
    loading = false;
    notifyListeners();
    print(room);
    return room;
  }
  addRoom(Room room) async{
    httpService.addRoom(room);
    notifyListeners();
  }
  // Future<Room> getRoom(int id) async{
  //   var res = httpService.getRoom(id);
  //   notifyListeners();
  //   return res;
  // }

}