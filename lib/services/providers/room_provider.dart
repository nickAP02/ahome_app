import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends ChangeNotifier{
  var room;
  List<Room> rooms=[];
  List<Device> roomDevice=[];
  double consoGlobale = 0;
  bool loading = false;
  List<Device> eclairageDevices = [];
  List<Device> infoDevices = [];
  List<Device> chauffageDevices = [];
  List<Device> electroDevices = [];
  List<Device> devicesAllumes =[];
  List<Device> devicesEteints =[];
  final HttpService httpService = HttpService();
  Future getRoomData() async{
    loading = true;
    room = await httpService.getRooms().then((value) => room=value);
    debugPrint("longueur "+room.toString());
    // rooms = room.map((e) => e.name).toList();
    // debugPrint("longueur rooms"+rooms.length.toString());
    // roomDevice =  room.map((e) => e.appareils);
    // debugPrint("longueur roomdevice"+roomDevice.length.toString());
    loading = false;
    notifyListeners();
    return room;
  }
  Future addRoom(Room room) async{
    debugPrint("ok add room");
    try{
       httpService.addRoom(room);
       debugPrint("ajout piece");
    }
   catch(e){
    debugPrint("erreur ajout piece");
    throw e.toString();
    
   }
    notifyListeners();
  }


  List<Device>getElectroDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return electroDevices;
  }
  setElectroDevices(){
    int index = 0;
    for(var item in room){
      if(item.appareils[index].categorie=="Electromenager"){
        electroDevices.add(item.appareils[index]);
        debugPrint("electro"+electroDevices.length.toString());
      }
    }
    notifyListeners();
  }
  List<Device>getChauffageDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return chauffageDevices;
  }
  setChauffageDevices(){
    int index = 0;
    for(var item in room){
      if(item.appareils[index].categorie=="Chauffage et climatisation"){
        chauffageDevices.add(item.appareils[index]);
        debugPrint("electro"+chauffageDevices.length.toString());
      }

    }
    notifyListeners();
  }
  List<Device>getInfoDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return infoDevices;
  }
  setInfoDevices(){
    int index = 0;
    for(var item in room){
      if(item.appareils[index].categorie=="Appareil informatique"){
        infoDevices.add(item.appareils[index]);
        debugPrint("electro"+infoDevices.length.toString());
      }
    }
    notifyListeners();
  }
  List<Device>getEclairDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return eclairageDevices;
  }
  setEclairageDevice(){
    int index = 0;
    for(var item in room){
      if(item.appareils[index].categorie=="Eclairage"){
        eclairageDevices.add(item.appareils[index]);
        debugPrint("electro"+eclairageDevices.length.toString());
      }
    }
    notifyListeners();
  }
  double getConsoGlobale(){
    consoGlobale = 0;
    return consoGlobale;
  }
  
}