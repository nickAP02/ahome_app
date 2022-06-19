import 'package:flutter/material.dart';
//classe qui permet de definir les themes de l'application
class Themes{
  //variable pour definir le theme clair
  static final light = 
  ThemeData(
    colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(247,248,250,1),
    onPrimary: Colors.black,
    secondary: Colors.black,
    onSecondary: Colors.black,
    error: Colors.black, 
    onError: Colors.black,
    background: Colors.black,
    onBackground: Colors.black,
    surface: Colors.black,
    onSurface: Colors.black
    )
  );
  //variable pour definir le theme sombre
  static final dark = 
  ThemeData(
    primaryColor: Colors.black,
    brightness:Brightness.dark
  );
}