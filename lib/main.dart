import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/planning_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/services/theme_service.dart';
import 'package:ago_ahome_app/utils/theme.dart';
import 'package:ago_ahome_app/views/screen/auth/login.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ago_ahome_app/utils/splash_screen.dart';
void main()async {
  //fonction qui permet de verifier l'utilisation d'un widget
  WidgetsFlutterBinding.ensureInitialized();
  //initialisation de get_storage
  await GetStorage.init();
  //demarrage de l'application
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<DeviceProvider>(create:(context)=>DeviceProvider()),
      ChangeNotifierProvider<RoomProvider>(create:(context)=>RoomProvider()),
      ChangeNotifierProvider<CapteurProvider>(create: (context)=>CapteurProvider()),
      ChangeNotifierProvider<UserProvider>(create: (context)=>UserProvider()),
      ChangeNotifierProvider<PlanningProvider>(create: (context)=>PlanningProvider()),
    ],
    child: MaterialApp(
        theme:Themes.light,
        themeMode: ThemeService().theme,
        darkTheme:Themes.dark, 
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
        body: Home()
        ),
      )
    );
    
  }
  @override
  void dispose(){
      super.dispose();
  }
}