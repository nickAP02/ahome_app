import 'package:ago_ahome_app/model/user.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  List<User>? users = [];
  bool loading = false;
  final HttpService httpService = HttpService();
  Future getUserData() async{
    loading = true;
    users = await httpService.getUsers();
    loading = false;
    notifyListeners();
    return users;
  }
  Future register(User user) async{
    httpService.register(user);
    notifyListeners();
  }
  Future login(User user) async{
    httpService.login(user);
    notifyListeners();
  }
}