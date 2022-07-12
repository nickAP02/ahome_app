import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
//connection avec l'api 
class HttpService{
  //initialisation du client http
  static final client = http.Client();
  static const url = "http://10.20.1.1:5000/api/v1";
  Map<String,String> headers = 
  {
    'Content-Type':'application/json',
    'Accept':"application/json"
  };
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
            "username":user.username,
            "password":user.password,
      }));
      //print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body)); 
      } 
      else {
        return response.statusCode.toString();
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

//implementation de la route /register
  Future register(User user) async{
    try {
      var response = await client.post(
      fullUri("register"), 
      headers: headers,
      body: json.encode({
          "username":user.username,
          "password":user.password,
          "email":user.email,
      }));
      if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
      }
      else {
        Exception("La requête n'a pas aboutie : ${response.statusCode}");
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
            debugPrint("body "+json.decode(response.body));
            return json.decode(response.body);
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
      debugPrint("bam"+json.decode(response.body.toString()));
      //return Room.fromJson(json.decode(response.body));
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
      debugPrint('premier');
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
      debugPrint("liste "+devices[0].idDev);
      debugPrint("cat"+devices[0].categorie!);
      debugPrint("puissance"+devices[0].puissance.toString());
      debugPrint("conso"+devices[0].conso.toString());
      debugPrint("state"+devices[0].state.toString());
      debugPrint("room"+devices[0].room.toString());
      return devices;
    }  catch (err) {
      debugPrint("devices ici");
      throw err.toString();
    }
  }
 //implementation de la route /rooms
  Future getRooms() async{
    List<Room>rooms=[];
    try {
      var response = await http.get(
        fullUri("rooms"),
        headers:headers
      );
      var data= json.decode(response.body) ;
      data.forEach((element)=>{
        rooms.add(Room.fromJson(element))
      });
      return rooms;
    }  catch (err) {
      debugPrint("rooms ici");
      throw err.toString();
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
  
  //   Future<Room> updateRoom(Room room) async{
  //     try {
  //       var response= await http.put(Uri.parse('http://ahome.ago:5000/api/v1/device/update/'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: {
  //           jsonEncode(room.toJson())
  //         });
  //         if (response.statusCode == 200) {
  //         return Room.fromJson(jsonDecode(response.body));
  //       }
  //       else {
  //         throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
  //       }
  //     } on Exception catch (e) {
  //             debugPrint("update room");
  //       throw e;
  //     }
  //   }
  //   Future<Room> deleteRoom(Room room) async{
  //       try {
  //         var response= await http.put(Uri.parse('http://ahome.ago:5000/api/v1/device/delete/${room.idRoom}'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: {
  //           jsonEncode(room.toJson())
  //         });
  //         if (response.statusCode == 200) {
  //         return Room.fromJson(jsonDecode(response.body));
  //               }
  //               else {
  //         throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
  //               }
  //       } on Exception catch (e) {
  //         debugPrint("delete room");
  //         throw e;
  //       }
  //   }
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
  //   Future<Device> updateDevice(Device device) async{
  //   var response = await http.put(Uri.parse('http://ahome.ago:5000/api/v1/device/update/'),
  //   headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: {
  //       jsonEncode(device.toJson())
  //     });
  //     if (response.statusCode == 200) {
  //     return Device.fromJson(jsonDecode(response.body));
  //     }
  //     else {
  //     throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
  //   }
  // }
  
}