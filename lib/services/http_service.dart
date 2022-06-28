import 'dart:convert';
import 'dart:io';
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
    var response = await client.post(registerUrl, body: {
      "username":user.username,
      "password": user.password,
      "email": user.email
    });
    if (response.statusCode == 200) {
     return jsonDecode(response.body);
    }
    else {
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  //implementation de la route /device/add
  static addDevice(Device device) async{
    var response = await client.put(Uri.parse('http://ahome.ago:5000/api/v1/device/update/${device.idDev}/${device.nameDev}'), body: {
      "conso":device.conso.toDouble(),
    });
    if (response.statusCode == 200) {
     return jsonDecode(response.body);
    }
    else {
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  //implementation de la route /room/add
  static addRoom(Room room) async{
    var response = await client.post(Uri.parse('http://ahome.ago:5000/api/v1/room/add'),body: {
      "name":room.nameRoom,
      "categorie":room.categorie
    });
  }
  //implementation de la route /users
   Future<List<User>?>getUsers() async{
    var response = await client.get(Uri.http(url,"users"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
    }
    else{
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
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
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
 //implementation de la route /rooms
  Future getRooms() async{
    final response = await client.get(Uri.parse('http://127.0.0.1:5000/api/v1/rooms'));
    if(response.statusCode == 200){
      var data = json.decode(response.body).cast<Map<String, dynamic>>(response);
      return data.map<Room>((json)=>Room.fromJson(json)).toList();
    }  
    else{
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }

}