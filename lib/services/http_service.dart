import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
//connection avec l'api
class HttpService{
  //initialisation du client http
  static final client = http.Client();
  static const url = "http://127.0.0.1:5000/api/v1/";
  static var loginUrl = Uri.http(url,"login");
  static var registerUrl =  Uri.http(url,"register");
  //implementation de la route /login
  static login(User user) async{
    var response = await client.post(loginUrl,
    body: {
      "username":user.username,
      "password":user.password
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
      "username":user.username,
      "password": user.password,
      "email": user.email
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
    Map data = {
      "id" : device.idDev,
      "name":device.nameDev.toString(),
      "conso":double.tryParse('${device.conso}'),
      "state":device.conso,
      "dateConso":device.dateConso
    };
    var response = await client.put(
      Uri.parse('http://ahome.ago:5000/api/v1/device/update/${device.idDev}'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(data));
    if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  //implementation de la route /room/add
  Future<Room> addRoom(Room room) async{
    Map data = {
      "id":room.idRoom,
      "name":room.nameRoom,
      "appareils":room.device
    };
    var response = await client.post(
      Uri.parse('http://ahome.ago:5000/api/v1/room/add/${room.idRoom}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        data
      });
      if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }

  }
  //implementation de la route /users
   Future<List<User>?>getUsers() async{
    var response = await client.get(Uri.http(url,"users"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
    }
    else{
      Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
    return null;
  }
  //implementation de la route /devices
  Future<List<Device>?>getDevices() async{
    var response = await client.get(Uri.http(url,"devices"));
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
    final response = await client.get(Uri.parse('http://127.0.0.1:5000/api/v1/rooms'));
    if(response.statusCode == 200){
      var data = json.decode(response.body).cast<Map<String, dynamic>>(response);
      return data.map<Room>((json)=>Room.fromJson(json)).toList();
    }  
    else{
      Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  Future<Room> getRoom(int id) async{
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
  Future<Device> getDevice(int id) async{
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
}