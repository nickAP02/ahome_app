import 'dart:convert';
import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';
//connection avec l'api 
class HttpService{
  //initialisation du client http
  static final client = http.Client();
  static const url = "http://10.20.1.1:5000/api/v1";
  //  static const url = "http://127.0.0.1:5000/api/v1";
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
  //implementation de la route /login
  Future login(User user) async{
    try {
      var response = await client.post(
      fullUri("login"),
      headers:headers,
      body: json.encode({
            "username":user.email,
            "password":user.password,
      }));
      debugPrint("api response"+response.toString());
      debugPrint("api response"+response.body);
      debugPrint("api status"+response.statusCode.toString());
      //print(jsonDecode(response.body));
      if (response.statusCode == 200) {
       
        var result=json.decode(response.body);
        return result;
      } 
      else {
        debugPrint(response.toString());
        var result=json.decode(response.body);
        return result;
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

//implementation de la route /register
  Future<dynamic>  register(User user) async{
    var result;
    try {
      print("ok");
      var response = await client.post(
      fullUri("register"), 
      headers: headers,
      body: json.encode({
          "username":user.username,
          "password":user.password,
          "email":user.email,
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
        // debugPrint("response result "+result["result"]);
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
    try {
      final response = await client.post( 
        fullUri("room/add"),
        headers: headers,
        body: json.encode({
          "name": room.nameRoom,
        })
      );
      var result=json.decode(response.body);
      return result["result"];
    }  catch (err) {
      debugPrint("add room");
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
     // debugPrint("yes "+response.body.toString());
     if(response.statusCode==200){
        var data= json.decode(response.body);
        // debugPrint(response);
          data.forEach((element)=>{
          // debugPrint(element),
            devices.add(Device.fromJson(element))
          }
        );
     }
      else{
        throw Exception("");
      }
      // debugPrint("liste "+devices[0].idDev);
      // debugPrint("cat"+devices[0].categorie!);
      // debugPrint("puissance"+devices[0].puissance.toString());
      // debugPrint("conso"+devices[0].conso.toString());
      // debugPrint("state"+devices[0].state.toString());
      // debugPrint("room"+devices[0].room.toString());
      return devices;
    }  catch (err) {
      debugPrint("devices ici");
      throw err.toString();
    }
  }
 //implementation de la route /rooms
  Future getRooms() async{
    debugPrint("rooms");
    List<Room>rooms=[];
    try {
      var response = await http.get(
        fullUri("rooms"),
        headers:headers
      );
      var data= json.decode(response.body);
      data.forEach((element)=>{
        rooms.add(Room.fromJson(element))
      });
      return rooms;
    }  catch (err) {
      debugPrint("rooms erreur");
      throw err.toString();
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
        debugPrint(data);
        data.forEach((element)=>{
          capteurs.add(Capteur.fromJson(element))
        });
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
  //   Future<Room> getRoom(String id) async{
  //     try {
  //         var response = await http.get(Uri.parse('http://ahome.ago:5000/api/v1/device/read/${id}'));
  //         // print(response);
  //         // print(response.body);
  //           if (response.statusCode == 200) {
  //             return Room.fromJson(jsonDecode(response.body));
  //           }
            
  //           else {
  //             throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
  //           }
  //       } on Exception catch (e) {
  //         throw e;
  //       }
  //   }
  
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
  // Future<Device> getDevice(String id) async{
  //     var response = await http.get(Uri.parse('http://ahome.ago:5000/api/v1/device/read/${id}'));
  //     // print(response);
  //     // print(response.body);
  //     try {
  //       if (response.statusCode == 200) {
  //         return jsonDecode(response.body);
  //       }
    
  //       else {
  //         throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
  //       }
  //     } on Exception catch (e) {
  //       throw Exception(e.toString());
  //     }
  //   }
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
    //  Future<Device> deleteDevice(Device device) async{
    //   try{
    //       var response = await client.delete(
    //       fullUri('device/delete'), 
    //       headers: headers,
    //       body:json.encode(device.toJson()));
    //       if (response.statusCode == 200) {
    //         // debugPrint("device enregistre");
    //         debugPrint("body "+json.decode(response.body));
    //         var result=json.decode(response.body);
    //         return result["result"];
    //       }
    //       else {
    //         throw json.decode(response.body);
    //       }
    //     }catch (e) {
    //       debugPrint("add device");
    //       throw e.toString();
    //     }
    //  }
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
    Future getRoomDevice(String name) async{
      List<Device> devices = [];
      try{
        var response = await http.get(
          fullUri("device/room/${name}"),
          headers: headers
        );
        var data = json.decode(response.body);
        data.forEach((element)=>{
          devices.add(Device.fromJson(element))
        });
        return devices;
      }catch(e){
        throw e.toString();
      }
    }
}