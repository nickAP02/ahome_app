import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends ChangeNotifier{
  var room;
  List<Room> rooms=[];
  List<dynamic> roomDevices=[];
  List<Device> roomOnDevices =[];
  int roomIndex=0;
  var roomOffDevices;
  var nbOnDevices;
  var nbOffDevices;
  double roomConso = 0;
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

  List<Room>getRooms(){
    rooms = room["result"].where((element)=>element["appareils"].isNotEmpty).toList();
    debugPrint("liste rooms "+rooms.toString());
    // rooms.forEach(debugPrint);
    notifyListeners();
    return rooms;
  }

  List<Device>getOnDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return roomOnDevices;
  }

  // setOnDevices(){
  //   for(int i=0;i<rooms.length;i++){
  //     roomOnDevices = rooms[i].appareils.where((element) => element.state[0]==1).toList();
  //   }
  //   debugPrint("liste device on "+roomOnDevices.toList().toString());
  //   debugPrint("liste device taille "+roomOnDevices.length.toString());
  //   notifyListeners();
  // }

  int getOffDevices(String id){
    var result = httpService.getRoomDeviceOff(id).then((value){
      nbOffDevices=value;
      debugPrint("off "+nbOffDevices.toString());
    });
    notifyListeners();
    return nbOffDevices.length;
  }

  int getNbOnDevices(String id){
    var result = httpService.getRoomDeviceOn(id).then((value){
      nbOnDevices=value;
      debugPrint("on "+nbOnDevices.toString());
  });
    debugPrint("nb on "+nbOnDevices.toString());
    notifyListeners();
    return nbOnDevices.length;
   
  }

  // setOffDevices(){
  //   for(int i=0;i<rooms.length;i++){
  //     roomOffDevices = rooms[i].appareils.where((element) => element.state[0]==0).toList();
  //   }
  //   debugPrint("liste device off "+roomOffDevices.toList().toString());
  //   debugPrint("liste device off taille "+roomOffDevices.length.toString());
  //   notifyListeners();
  // }


//  int getNbOffDevices(){
  
//     notifyListeners();
//   }

  getRoomConso(String id){
    var result = httpService.getRoomConso(id).then((value){
      roomConso=value.toDouble();
      debugPrint("valeur conso "+roomConso.toString());
      });
    debugPrint("conso result "+result.toString());
    notifyListeners();
    return roomConso;
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

  getConsoGlobale(){
    var result = httpService.getConso().then((value){
      consoGlobale=value;
      debugPrint("valeur conso g "+consoGlobale.toString());
      });
    notifyListeners();
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