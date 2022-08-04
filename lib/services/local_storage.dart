import 'dart:convert';

// import 'package:ago_ahome_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LocalStorage{

    Future setToken(String token)async{
      var pref = await SharedPreferences.getInstance();
      return pref.setString("token", json.encode(token));
    }

     Future getToken()async{
      var pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      return token;
    }
    // Future setRole(String name)async{
    //   var pref = await SharedPreferences.getInstance();
    //   return pref.setString("role", name);
    // }
    getUser() async{
      var pref = await SharedPreferences.getInstance();
      var value = pref.getString("user");
      return value;
    }
    setUser(String user)async{
      var pref = await SharedPreferences.getInstance();
      var value = pref.setString("user", json.encode(user));
      return value;
    }
    logout()async{
      var pref = await SharedPreferences.getInstance();
      pref.remove("user");
      pref.remove("token");
    }

}