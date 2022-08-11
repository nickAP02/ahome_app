import 'dart:convert';
import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/planning.dart';
import 'package:ago_ahome_app/model/role.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
//connection avec l'api 
class HttpService{
  //initialisation du client http
  static final client = http.Client();
  // static const url = "http://10.20.1.1:5000/api/v1";
  static const url = "http://192.168.0.106:5000/api/v1";
  Map<String,String> headers = 
  {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };
  Map<String,String> headersBearer(String token)
  {
    return {
      'Content-Type':'application/json',
      'Accept':'application/json',
      'Authorization':"Bearer $token"
    };
  }
  Uri fullUri(String uri){
    return Uri.parse('$url/$uri');
  }

    Future addRole(Role role)async{
    try{
      var response  = await client.post(
        fullUri('/role/add'),
        headers: headers,
        body:  json.encode({
          "roleName":role.roleName
        })
       );
       var result=json.decode(response.body);
       if(result["statut"] == 200){
        return result;
      }
      else{
        return result;
      }
    }on Exception catch (e) {
      throw e.toString();
    }
  }
 Future updateRole(Role role)async{
    try{
      var response  = await client.post(
        fullUri('/role/update/${role.id}'),
        headers: headers,
        body:  json.encode({
          "roleName":role.roleName
        })
       );
       return response.body;
    }on Exception catch (e) {
      throw e.toString();
    }
  }
  Future getRoles()async{
    try{
      var response  = await client.get(fullUri('/roles'));
      var result=json.decode(response.body);
     if(result["statut"] == 200){
        return result;
      }
      else{
        return result;
      }
    }on Exception catch (e) {
      throw e.toString();
    }
  }
  //implementation de la route /login
  Future login(User user) async{
    try {
      var response = await client.post(
      fullUri("login"),
      headers:headers,
      body: json.encode({
            "email":user.email,
            "password":user.password,
            // "role_id":user.roles!.roleName.toString()
      }));
      var result=json.decode(response.body);
      if(result["statut"]==200){
          LocalStorage().setToken(result["token"]);
          debugPrint("pref token"+LocalStorage().getToken().then((value) => value.toString()).toString());

        }
        else{
          debugPrint("statut "+result['statut']);
          return result;
        }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

//implementation de la route /register
  Future<dynamic> register(User user) async{
    // var result;
    try {
      debugPrint("ok");
      var response = await client.post(
      fullUri("register"), 
      headers: headers,
      body: json.encode({
          "username":user.username,
          "password":user.password,
          "email":user.email
      }));
      var result=json.decode(response.body);
      debugPrint("api status "+result.toString());
      // debugPrint("api response "+result["result"]);

      if(result["statut"] == 200){
        return result;
      }
      else{
        return result;
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }
  //implementation de la route /device/add
  Future addDevice(Device device) async{
      try {
        var response = await client.put(
          fullUri('device/update'), 
          headers: headers,
          body:json.encode(device.toJson()));
          var result=json.decode(response.body);
          if (result["statut"] == 200) {
            // debugPrint("device enregistre");
            // debugPrint("body "+json.decode(response.body.toString()));
            return result;
          }
          else {
            return result;
          }
        } on Exception catch (e) {
          debugPrint("add device");
          throw e.toString();
      }
  }
  
   addRoom(Room room) async{
    debugPrint("add room ici");
    try {
       debugPrint("add room catch");
      final response = await client.post( 
        fullUri("room/add"),
        headers: headers,
        body: json.encode({
          "name": room.nameRoom,
        })
      );
      var result=json.decode(response.body);
      if(result["statut"] == 200){
        return result;
      }
      else{
        return result;
      }
    }  catch (err) {
      debugPrint("add room erreur");
      debugPrint(err.toString());
      throw err.toString();
    }

  }
  //implementation de la route /users
   Future<List<User>?>getUsers() async{
    // List<User> users = [];
    try {
      var response = await client.get(
        fullUri("users"),
        headers: headers);
        var result=json.decode(response.body);
      if(result["statut"] == 200){
        return result;
      }
      else{
        return result;
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }
  //implementation de la route /devices
  Future<List<Device>?>getDevices() async{
    List<Device> devices = [];
    try {
      debugPrint('devices');
      var response = await http.get(
        fullUri("devices"),
         headers: headers
      );
      debugPrint(response.body);
      var data = json.decode(response.body);
     // debugPrint("yes "+response.body.toString());
      if(data["statut"]==200){
          data["result"].forEach((element)=>{
            debugPrint("il se passse qlq chose"),
            devices.add(Device.fromJson(element))
          });
          debugPrint("liste devices " +devices.toString());
        }
        else{
          debugPrint(data);
        }
      return devices;
    }  catch (err) {
      debugPrint("devices ici");
      throw err.toString();
    }
  }
 //implementation de la route /rooms
  Future getRooms() async{
    debugPrint(" entree rooms");
    var rooms;
    try {
      var response = await http.get(
        fullUri("rooms"),
        headers:headers
      );
      var data= json.decode(response.body);
      // debugPrint("ok "+data.toString());
      
      if(data["statut"]==200){
        
        //   data["result"].forEach((element)=>{
        //   debugPrint("rooms "+element.toString()),
        //   rooms.add(Room.fromJson(element)),
        //   // debugPrint("rooms "+rooms.toString())
        // });
        rooms = data;
        // debugPrint("rooms "+rooms.toString());
        // debugPrint("rooms result "+rooms["result"]);
        // debugPrint("rooms op "+rooms["statut"]);
        // debugPrint("rooms op 0"+rooms["result"][0]["appareils"].toString());
        // debugPrint("rooms op 1"+rooms[0]["id"].toString());
        // debugPrint("rooms op 2"+rooms[0]["name"].toString());
        return rooms;
      }
      else{
        debugPrint("erreur "+data.toString());
      }
      debugPrint("fin rooms "+rooms.toString());
      return rooms;
      }  catch (err) {
        debugPrint("rooms exception");
      }
  }
  Future getCapteurs() async{
     debugPrint("capteurs");
    List<Capteur> capteurs = [];
      try {
        var response = await http.get(
          fullUri("capteurs"),
          headers: headers
        );
        var data = json.decode(response.body);
        debugPrint(data.toString());
        if(data["statut"]==200){
            data["result"].forEach((element)=>{
              debugPrint("ici capteurs"),
            capteurs.add(Capteur.fromJson(element))
          });
        }
        else{
          debugPrint(data);
        }
        return capteurs;
      } on Exception catch (e) {
        debugPrint("capteurs ici");
        throw e.toString();
      }
    }
    Future addCapteur(Capteur capteur) async{
      try {
        var response = await http.put(
          fullUri("capteur/update"),
          headers: headers,
          body: json.encode({
          "id":capteur.id,
          "nameRoom":capteur.nameRoom,
          })
        );
        var result=json.decode(response.body);
        if (result["statut"] == 200) {
          // debugPrint("body "+json.decode(response.body.toString()));
          
          debugPrint(result["result"]);
          return result;
        }
        else {
           return result;
        }
      } on Exception catch (e) {
        debugPrint("capteurs ici");
        throw e.toString();
      }
    }

    Future<Room> updateRoom(Room room) async{
      try {
        var response= await http.put(
          fullUri("room/update"),
          headers: headers,
          body: {
            jsonEncode(room.toJson())
          });
          var result=json.decode(response.body);
          if (result["statut"] == 200) {
          return result;
        }
        else {
          return result;
        }
      } on Exception catch (e) {
        debugPrint("update room");
        throw e.toString();
      }
    }

    Future<Room> deleteRoom(Room room) async{
        try {
          var response= await http.delete(
          fullUri("room/delete"),
          headers: headers,
          body: {
            jsonEncode(room.toJson())
          });
          var result=json.decode(response.body);
          if (result["statut"] == 200) {
           return result;
          }
          else {
            return result;
          }
        }catch (e) {
          debugPrint("delete room");
          throw e.toString();
        }
    }
 
    Future<Device> updateDevice(Device device) async{
      try{
          var response = await http.put(
          fullUri('device/update'), 
          headers: headers,
          body:json.encode({
          "id":device.idDev,
          "name":device.nameDev,
          "state":device.state,
          "puissance":device.puissance,
          "nameRoom":device.room,
      })
        );
          if (response.statusCode == 200) {
            // debugPrint("device enregistre");
            debugPrint("body "+json.decode(response.body));
            var result=json.decode(response.body);
            return result["result"];
          }
          else {
            throw json.decode(response.body);
          }
        }catch (e) {
          debugPrint("add device");
          throw e.toString();
        }
     }
     Future<Device> deleteDevice(Device device) async{
      try{
          var response = await client.delete(
          fullUri('device/delete'), 
          headers: headers,
          body:json.encode(device.toJson()));
          var result=json.decode(response.body);
          if (result["statut"] == 200) {
            debugPrint("body "+result.toString());
            
            return result["result"];
          }
          else {
            throw json.decode(response.body);
          }
        }catch (e) {
          debugPrint("add device");
          throw e.toString();
        }
     }
 
    Future getTemperature(String name) async{
      try{
        var response = await http.get(
          fullUri("temperature/$name"),
          headers: headers
        );
        var data =json.decode(response.body);
        debugPrint("temp"+data.toString());
        return data;
        
      }catch(e){
        throw e.toString();
      }
    }

    Future getRoomDeviceOn() async{
     List<Room> pieces=[];
      try{
        var response = await http.get(
          fullUri("device/room/on"),
          headers: headers
        );
        var data = json.decode(response.body);
        data.forEach((element)=>{
          pieces.add(Room.fromJson(element))
        });
        return pieces;
      }catch(e){
        throw e.toString();
      }
    }

    Future<Planning> addPlanning(Planning planning) async{
      try{
          var response = await http.post(
            fullUri("planning/add"),
            headers: headers,
            body:json.encode({
            // "id":planning.idPlan,
            "name":planning.nomPlan,
            "dateDebut":planning.dateDebut,
            "dateFin":planning.dateFin,
            "appareils":planning.appareils
            })
          );
          var data =response.body;
          var result=json.decode(data);
            debugPrint("statut "+result["statut"].toString());
            debugPrint("result "+result["result"].toString());
          if(result["statut"] == 200) {
            // debugPrint("device enregistre");
            // debugPrint("body "+json.decode(response.body.toString()));
            debugPrint("statut "+result["statut"]);
            debugPrint("result "+result["result"]);
            return result;
          }
          else {
            debugPrint("else");
            return result;
          }
        } on Exception catch (e) {
        debugPrint("add planning");
        throw e.toString();
      }
    }
   Future<Planning> updatePlanning(Planning planning) async{
      try{
          var response = await http.put(
            fullUri("planning/update"),
            headers: headers,
            body:json.encode({
            "id":planning.idPlan,
            "name":planning.nomPlan,
            "dateHeure":planning.dateDebut,
            "dateFin":planning.dateFin,
            "appareils":planning.appareils
            })
          );
          var result=json.decode(response.body);
          if(result["statut"] == 200) {
            // debugPrint("device enregistre");
            // debugPrint("body "+json.decode(response.body.toString()));
            debugPrint("result "+result["result"]);
            return result["result"];
          }
          else {
            throw json.decode(response.body);
          }
        } on Exception catch (e) {
        debugPrint("add planning");
        throw e.toString();
      }
    }
    Future deletePlanning(String id) async{
      try{
          var response = await http.delete(
            fullUri("planning/delete"),
            headers: headers,
            body:json.encode({
            "id":id
            })
          );
          if(response.statusCode == 200) {
            // debugPrint("device enregistre");
            // debugPrint("body "+json.decode(response.body.toString()));
            var result=json.decode(response.body);
            debugPrint(result["result"]);
            return result["result"];
          }
          else {
            throw json.decode(response.body);
          }
        } on Exception catch (e) {
        debugPrint("add planning");
        throw e.toString();
      }
    }

    Future onPlanning(String id)async{
       debugPrint("planning on ici");
       var response = await http.post(
        fullUri("planning/on/$id"),
        headers: headers,
        body: json.encode(
          {
            "id":id
          }
        )
      );
    }

    Future offPlanning(String id)async{
       debugPrint("planning off ici");
       var response = await http.post(
        fullUri("planning/off/$id"),
        headers: headers,
        body: json.encode(
          {
            "id":id
          }
        )
      );
    }

    Future getPlannings() async{
      debugPrint("planning arrive ici");
      List<Planning> plannnings=[];
      try{
        var response = await http.get(
          fullUri("plannings"),
          headers: headers
        );
        var data = json.decode(response.body);
        if(data["statut"]==200){
          data["result"].forEach((element)=>{
            // debugPrint("planning ici av"+element.toString()),
            plannnings.add(Planning.fromJson(element)),
            debugPrint("planning ici ap"+element.toString())
          });
        }
        else{
          debugPrint("erreur "+data.toString());
        }

        return plannnings;
      }catch(e){
        throw e.toString();
      }
    }
}