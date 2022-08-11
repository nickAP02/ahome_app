import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends ChangeNotifier{
  var room;
  List<String> rooms=[];
  List<dynamic> roomDevices=[];
  List<Device> roomOnDevices =[];
  int roomIndex=0;
  var roomOffDevices;
  var nbOnDevices;
  double consoGlobale = 0;
  int index = 0;
  bool loading = false;
  final HttpService httpService = HttpService();

  Future getRoomData() async{
    loading = true;
    room = await httpService.getRooms().then((value) => room=value);
    loading = false;
    debugPrint("room provider "+room.toString());
    notifyListeners();
    return room;
  }
  
  // getRoomDevice(){
  //   roomDevices = room["result"][index]["appareils"].toList();
  //  debugPrint("liste device room "+roomDevices.toString());
  //   // notifyListeners();
  //   return roomDevices;
  // }

  // List<String>getRoomsName(){
  //   rooms = room["result"][index]["name"].toList();
  //   debugPrint("liste name "+rooms.toString());
  //   // rooms.forEach(debugPrint);
  //   notifyListeners();
  //   return rooms;
  // }

  List<Device>getOnDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return roomOnDevices;
  }

  setOnDevices(){
    roomOnDevices = room["result"]!.where((element) => element.appareils.state[0]==1).toList();
    notifyListeners();
  }

  List<Device>getOffDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return roomOffDevices;
  }

  getNbOnDevices(){
    nbOnDevices = roomDevices.length;
    notifyListeners();
  }

  getRoomConso(){
    var valConso;
    for(int i=0;i<roomOnDevices.length;i++){
        valConso += roomOnDevices[i].conso;
        return valConso;
    }
    notifyListeners();
    return valConso;
  }
 
  Future<dynamic> addRoom(Room room) async{
    // debugPrint("ok add room");
    try{
       final result = httpService.addRoom(room);
      debugPrint("ajout piece"+result.toString());
      notifyListeners();
      return result ;
    }
   catch(e){
    debugPrint("erreur ajout piece");
    throw e.toString();
    
   }
    
  }

  double getConsoGlobale(){
    consoGlobale = 0;
    // notifyListeners();
    return consoGlobale;
  }
  
   Future updateRoom(Room room) async{
    httpService.updateRoom(room);
    notifyListeners();
  }

  Future<dynamic> deleteRoom(String id) async{
    httpService.deleteRoom(id);
    notifyListeners();
  }

}