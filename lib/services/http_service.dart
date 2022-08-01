import 'dart:convert';
import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/role.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
//connection avec l'api 
class HttpService{
  //initialisation du client http
  static final client = http.Client();
  //static const url = "http://10.20.1.1:5000/api/v1";
  static const url = "http://192.168.43.32:5000/api/v1";
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
       return response.body;
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
      if(response.statusCode==200){
        var result = json.decode(response.body);
        return result;
      }
      else {
        debugPrint("reponse "+response.body);
        var result=json.decode(response.body);
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
      // debugPrint("api response"+response.body);
      // debugPrint("api status"+response.statusCode.toString());
      
      
      //print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var result=json.decode(response.body);
        // debugPrint("result token"+result["token"]);
        // debugPrint("result statut"+result['statut'].toString());
        if(result["statut"]==200){
          LocalStorage().setToken(result["token"]);
          debugPrint("pref token"+LocalStorage().getToken().then((value) => value.toString()).toString());
        }
        else{
          debugPrint("statut "+result['statut']);
        }
        return result;
      } 
      else {
        debugPrint("api response"+response.body);
        var result=json.decode(response.body);
        return result;
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

//implementation de la route /register
  Future<dynamic> register(User user) async{
    var result;
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

      if (response.statusCode == 200) {
        result=json.decode(response.body);
        debugPrint("response result "+result.toString());
        return result;
      }
      
      else {
        result=json.decode(response.body);
        debugPrint("response statut "+result["statut"]);
        return result;
        // Exception("La requête n'a pas aboutie : ${response.statusCode}");
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
          if (response.statusCode == 200) {
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
          debugPrint("add device");
          throw e.toString();
      }
  }
  
  Future addRoom(Room room) async{
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
      return result;
    }  catch (err) {
      debugPrint("add room erreur");
      debugPrint(err.toString());
      throw err.toString();
    }

  }
  //implementation de la route /users
   Future<List<User>?>getUsers() async{
    List<User> users = [];
    try {
      var response = await client.get(
        fullUri("users"),
        headers: headers);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        return data;
      }
      else{
        Exception("La requête n'a pas aboutie : ${response.statusCode}");
      }
      return null;
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
      if(response.statusCode==200){
          data.forEach((element)=>{
            devices.add(Device.fromJson(element))
          });
        }
        else{
          debugPrint(data);
        }
    //  if(response.statusCode==200){
    //     var data= json.decode(response.body);
    //     // debugPrint(response);
    //       data.forEach((element)=>{
    //       // debugPrint(element),
    //         devices.add(Device.fromJson(element))
    //       }
    //     );
    //  }
      // else{
      //   throw Exception("");
      // }
      return devices;
    }  catch (err) {
      debugPrint("devices ici");
      throw err.toString();
    }
  }
 //implementation de la route /rooms
  Future getRooms() async{
    debugPrint(" entree rooms");
    List<Room>rooms=[];
    try {
      var response = await http.get(
        fullUri("rooms"),
        headers:headers
      );
   //   debugPrint("reponse "+response.body);
      // debugPrint("statu "+response.statusCode.toString());
      var data= json.decode(response.body);
        if(data["statut"]==200){
         debugPrint("erreur ici"+data.toString());
           data['result'].forEach((element)=>{
            rooms.add(Room.fromJson(element))
           });
    
          debugPrint("resultat "+rooms.toString());
        }
        else{
          debugPrint("erreur "+data.toString());
        }
      return rooms;
    }  catch (err) {
      debugPrint("rooms exception");
 //     throw err.toString();
    }
  }
  Future getCapteurs() async{
    List<Capteur> capteurs = [];
      try {
        var response = await http.get(
          fullUri("capteurs"),
          headers: headers
        );
        var data = json.decode(response.body);
        debugPrint(data.toString());
        if(response.statusCode==200){
          data.forEach((element)=>{
          capteurs.add(Capteur.fromJson(element))
        });
        }
       
        return capteurs;
      } on Exception catch (e) {
        debugPrint("capteurs ici");
        throw e.toString();
      }
    }
    Future addCapteur(Capteur capteur) async{
    // List<Capteur> capteurs = [];
      try {
        var response = await http.put(
          fullUri("capteur/update"),
          headers: headers,
          body: json.encode({
          "id":capteur.id,
          "nameRoom":capteur.nameRoom,
      })
        );
        if (response.statusCode == 200) {
          // debugPrint("body "+json.decode(response.body.toString()));
          var result=json.decode(response.body);
          debugPrint(result["result"]);
          return result["result"];
        }
        else {
          throw json.decode(response.body);
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
          if (response.statusCode == 200) {
          return Room.fromJson(jsonDecode(response.body));
        }
        else {
          throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
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
          if (response.statusCode == 200) {
            return Room.fromJson(jsonDecode(response.body));
          }
          else {
            throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
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
          "categorie":device.categorie,
          "puissance":device.puissance,
          "state":device.state,
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
 
    Future getTemperature(String name) async{
      try{
        var response = await http.get(
          fullUri("temperature/${name}"),
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

}