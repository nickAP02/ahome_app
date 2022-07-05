import 'package:ago_ahome_app/services/room_provider.dart';
import 'package:ago_ahome_app/services/theme_service.dart';
import 'package:ago_ahome_app/utils/theme.dart';
import 'package:ago_ahome_app/views/screen/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main()async {
  //fonction qui permet de verifier l'utilisation d'un widget
  WidgetsFlutterBinding.ensureInitialized();
  //initialisation de get_storage
  await GetStorage.init();
  //demarrage de l'application
  runApp(const MyHomePage()
    );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variable pour verifier le chargement des données venant de l'api
  var isLoaded = false;
  //fonction d'initialisation du cycle de vie de l'application
  @override
  void initState() {
    super.initState();
  }  
  //fonction de traitement du cycle de vie de l'application
  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider(
        create: (context)=>RoomProvider(),
        child: GetMaterialApp(
          theme:Themes.light,
          themeMode: ThemeService().theme,
          darkTheme:Themes.dark, 
          debugShowCheckedModeBanner: false,
          home: const Scaffold(
            body: Space(),
          ),
          ),
      );
  }
  //creer container
  //crer une colonne pour le bouton et le text
  //inserer un row dans le container
  //fonction de cloture du cycle de vie de l'application
  @override
  void dispose(){
      super.dispose();
  }
}