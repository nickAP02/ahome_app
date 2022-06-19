import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//gestion des themes de l'application
class ThemeService{
  final _box =  GetStorage(); 
  _saveThemeToBox(bool isDarkMode)=>_box.write(_key, isDarkMode);
  final _key = 'isDarkMode';
  //verification du theme de l'application
  bool _loadThemeFromBox()=>_box.read(_key)??false;
  //recuperation de la valeur du theme
  ThemeMode get theme => _loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;
  //methode qui permet de changer le theme
  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

}