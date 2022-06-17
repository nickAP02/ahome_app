import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
class HttpService{
  static final client = http.Client();
  static const url = "http://127.0.0.1:5000/api/v1/";
  static var loginUrl = Uri.http(url,"login");
  static var registerUrl =  Uri.http(url,"register");
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
  static addDevice(Device device) async{
    var response = await http.post(Uri.http(url, '/device/add'), body: {
      "name":device.name,
      "conso":device.conso,
      "state":device.state
    });
    if (response.statusCode == 200) {
     return jsonDecode(response.body);
    }
    else {
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  static addRoom(Room room) async{
    var response = await http.post(Uri.http(url, '/room/add'),body: {
      "name":room.name,
      "categorie":room.categorie
    });
  }
   Future<List<User>?>getUsers() async{
    var response = await http.get(Uri.http(url,"users"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
    }
    else{
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  Future<List<Device>?>getDevices() async{
    var response = await http.get(Uri.http(url,"devices"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
    }
    else{
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  Future<List<Room>?>getRooms() async{
    var response = await http.get(Uri.http(url,"rooms"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      Room.fromJson(data);
    }
    else{
      print("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }

}