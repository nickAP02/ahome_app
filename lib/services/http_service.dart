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
  static const url = "http://192.168.1.69:5000/api/v1";
  static var loginUrl = Uri.http(url,"login");
  static var registerUrl =  Uri.http(url,"register");
  Map<String,String> headers = {'Content-Type':'application/json','Accept':"application/json"};
  Uri fullUri(String uri){
    return Uri.parse('$url/$uri');
  }
  //implementation de la route /login
  static login(User user) async{
    var response = await client.post(loginUrl,
    body: {
      jsonEncode(user.toJson()),
    });
    //print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body); 
    } 
    else {
      return response.statusCode.toString();
    }
  }

//implementation de la route /register
  static register(User user) async{
    var response = await client.post(registerUrl, 
    headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: {
      user.toJson(),
    });
    if (response.statusCode == 200) {
     return jsonDecode(response.body);
    }
    else {
      Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  //implementation de la route /device/add
  Future<Device> addDevice(Device device) async{
    var response = await client.put(
      Uri.parse('http://ahome.ago:5000/api/v1/device/update/'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(device.toJson()));
    if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  //implementation de la route /room/add
  Future addRoom(Room room) async{
   
    try {
      final request = http.MultipartRequest("POST",Uri.parse("http://192.168.1.69:5000/api/v1/room/add/"),);
      request.fields["name"] = room.nameRoom;
      request.fields["capteur"] = room.capteur;
      request.headers.addAll( {'Content-Type':'application/json','Accept':"application/json"});
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      debugPrint("bam"+responseString);
    //   final response = await http.post( 
    //     fullUri("room/add"),
    //  headers: headers,
    //     body: json.encode({
    //       "name": room.nameRoom,
    //       "capteur":room.capteur
    //     }));
    //   debugPrint("bam"+json.decode(response.body.toString()));
    //return Room.fromJson(json.decode(response.body) as Map<String,dynamic>);
    }  catch (err) {
      print(err.toString());
      throw err;
    }

  }
  //implementation de la route /users
   Future<List<User>?>getUsers() async{
    var response = await client.get(Uri.http(url,"users"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
    return null;
  }
  //implementation de la route /devices
  Future<List<Device>?>getDevices() async{
    var response = await client.get(Uri.parse(url+"devices"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List<Device> devices = data.
      map(
        (dynamic item) =>Device.fromJson(item),
       ).toList();
       return devices;
    }
    else{
      Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
    return null;
  }
 //implementation de la route /rooms
  Future getRooms() async{
    List<Room>rooms=[];
    //print("hello");
    // final response = await client.get(Uri.parse('http://ahome.ago:5000/api/v1'));
    // if(response.statusCode == 200){
    //   var data = jsonDecode(response.body);
    //   print(data);
    //   return data.map<Room>((json)=>Room.fromJson(json)).toList();
    // }  
    // else{
    //   Exception("La requête n'a pas aboutie : ${response.statusCode}");
    // }
    try {
      var response = await http.get(
        fullUri("rooms"),
         headers: {
          'Content-Type': 'application/json',
          'Accept':'application/json'
        },);
     // debugPrint("yes "+response.body.toString());
      var data= json.decode(response.body) ;
      data.forEach((element)=>{
rooms.add(Room.fromJson(element))
      });
    return rooms;
    }  catch (err) {
     // print("elle");
      throw err;
    }
  }
  Future<Room> getRoom(String id) async{
    var response = await client.get(Uri.parse('http://ahome.ago:5000/api/v1/device/read/${id}'));
    // print(response);
    // print(response.body);
      if (response.statusCode == 200) {
        return Room.fromJson(jsonDecode(response.body));
      }
      
      else {
        throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
      }
  }
  
  Future<Room> updateRoom(Room room) async{
    var response= await client.put(Uri.parse('http://ahome.ago:5000/api/v1/device/update/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        jsonEncode(room.toJson())
      });
      if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  Future<Room> deleteRoom(Room room) async{
    var response= await client.put(Uri.parse('http://ahome.ago:5000/api/v1/device/delete/${room.idRoom}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        jsonEncode(room.toJson())
      });
      if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
Future<Device> getDevice(String id) async{
    var response = await client.get(Uri.parse('http://ahome.ago:5000/api/v1/device/read/${id}'));
    // print(response);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
  
      else {
        throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
    Future<Device> updateDevice(Device device) async{
    var response = await client.put(Uri.parse('http://ahome.ago:5000/api/v1/device/update/'),
    headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        jsonEncode(device.toJson())
      });
      if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
      }
      else {
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  
}