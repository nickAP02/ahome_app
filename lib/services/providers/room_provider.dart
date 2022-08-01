import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends ChangeNotifier{
  var room;
  var rooms;
  var roomOnDevices;
  var roomDevices;
  var roomOffDevices;
  var nbOnDevices;
  double consoGlobale = 0;
  bool loading = false;
  final HttpService httpService = HttpService();
  Future getRoomData() async{
    loading = true;
    room = await httpService.getRooms().then((value) => room=value);
    loading = false;
    notifyListeners();
    return room;
  }
  getRoomDevice(){
    roomOnDevices = room!.where((element) => element.appareils).toList();
  }
  // List<String>getRoomsName(){
  //   loading = true;
  //   notifyListeners();
  //   loading = false;
  //   return rooms;
  // }
  // setRoomsName(){
  //   rooms = room!.where((element) => element.name.isNotEmpty).toList();
  //   notifyListeners();
  // }
  List<Device>getOnDevices(){
    loading = true;
    notifyListeners();
    loading = false;
    return roomOnDevices;
  }
  setOnDevices(){
    roomOnDevices = room!.where((element) => element.appareils.state[0]==1).toList();
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
  // setOffDevices(){
  //   roomOffDevices = room!.where((element) => element.appareils.state[0]==0).toList();
  //   notifyListeners();
  // }
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


  // List<Device>getElectroDevices(){
  //   loading = true;
  //   notifyListeners();
  //   loading = false;
  //   return electroDevices;
  // }
  // setElectroDevices(){
  //   int index = 0;
  //   for(var item in room){
  //     if(item.appareils[index].categorie=="Electromenager"){
  //       electroDevices.add(item.appareils[index]);
  //       debugPrint("electro"+electroDevices.length.toString());
  //     }
  //   }
  //   notifyListeners();
  // }
  // List<Device>getChauffageDevices(){
  //   loading = true;
  //   notifyListeners();
  //   loading = false;
  //   return chauffageDevices;
  // }
  // setChauffageDevices(){
  //   int index = 0;
  //   for(var item in room){
  //     if(item.appareils[index].categorie=="Chauffage et climatisation"){
  //       chauffageDevices.add(item.appareils[index]);
  //       debugPrint("electro"+chauffageDevices.length.toString());
  //     }

  //   }
  //   notifyListeners();
  // }
  // List<Device>getInfoDevices(){
  //   loading = true;
  //   notifyListeners();
  //   loading = false;
  //   return infoDevices;
  // }
  // setInfoDevices(){
  //   int index = 0;
  //   for(var item in room){
  //     if(item.appareils[index].categorie=="Appareil informatique"){
  //       infoDevices.add(item.appareils[index]);
  //       debugPrint("electro"+infoDevices.length.toString());
  //     }
  //   }
  //   notifyListeners();
  // }
  // List<Device>getEclairDevices(){
  //   loading = true;
  //   notifyListeners();
  //   loading = false;
  //   return eclairageDevices;
  // }
  // setEclairageDevice(){
  //   int index = 0;
  //   for(var item in room){
  //     if(item.appareils[index].categorie=="Eclairage"){
  //       eclairageDevices.add(item.appareils[index]);
  //       debugPrint("electro"+eclairageDevices.length.toString());
  //     }
  //   }
  //   notifyListeners();
  // }
  double getConsoGlobale(){
    consoGlobale = 0;
    return consoGlobale;
  }
  
}