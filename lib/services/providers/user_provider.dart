import 'dart:convert';

import 'package:ago_ahome_app/model/role.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
class UserProvider extends ChangeNotifier{
  var result;
  var userLogin;
  User userRole=User(email: "",password: "",username: "",roles: Role(roleName: ""));
  List<User>? users = [];
  bool loading = false;
  final LocalStorage localStorage =  LocalStorage();
  final HttpService httpService = HttpService();
  Future getUserData() async{
    loading = true;
    users = await httpService.getUsers();
    loading = false;
    notifyListeners();
    return users;
  }
  Future<dynamic> register(User user) async{
    result = httpService.register(user);
    // print(result.toString());
    notifyListeners();
    return result;
  }
  login(User user) async{
    await httpService.login(user).then((value) => userLogin = value);
    notifyListeners();
    // return userLogin;
  }
  Future<dynamic> getUser()async{
    userRole = json.decode(localStorage.getUser());
  }
}