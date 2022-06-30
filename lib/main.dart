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
          home: Scaffold(
            // appBar: AppBar(
            //   title:const Text('AGO AHOME'),
            //   //leading: const Icon(Icons.menu),
            //   actions: const [
            //     Padding(
            //       padding: EdgeInsets.symmetric(vertical: 12,
            //       horizontal: 16),
            //       child: CircleAvatar(
            //         maxRadius: 15,
            //         backgroundImage: AssetImage("assets/lightning.png"),
            //       ),),
            //   ],
            // ),
            // drawer: Drawer(
            //   backgroundColor: const Color.fromRGBO(20,115,209,1),
            //   elevation:300,
            //   width: 100,
            //   child: ListView(
            //     children: [
            //       ListTile(
            //         leading:IconButton(
            //           icon:const Icon(Icons.dark_mode),
            //           onPressed: (){
            //             ThemeService().switchTheme();
            //           },
            //         ),
            //       ),
            //       ListTile(
            //         subtitle: const Text("Accueil",
            //         style: TextStyle(
            //           color: Colors.white
            //         ),),
            //         leading: IconButton(
            //           icon:const Icon(Icons.home,color: Colors.white,),
            //           onPressed: (){
            //             Navigator.of(context).push(MaterialPageRoute(
            //             builder: (BuildContext context) => const MyHomePage()));
            //           },
            //         ),
            //       ),
            //       ListTile(
            //         subtitle: const Text("Pièces", 
            //         style:TextStyle(color:Colors.white)
            //         ),
            //         leading: IconButton(
            //           icon:const Icon(Icons.meeting_room_outlined,color: Colors.white,),
            //           onPressed: (){
            //             Navigator.of(context).push(MaterialPageRoute(
            //             builder: (BuildContext context) => const RoomDevice()));
            //           },)
            //         ),
            //       ListTile(
            //         subtitle: const Text("Appareils",
            //         style:TextStyle(color:Colors.white)
            //         ),
            //         leading: IconButton(
            //           icon:const Icon(Icons.devices,color: Colors.white,),
            //           onPressed: (){
            //           Navigator.of(context).pop();
            //           }
            //         )
            //         ),
            //       ListTile(
            //         leading:IconButton(onPressed: (){
            //           Navigator.of(context).pop();
            //         }, icon: const Icon(Icons.logout,color: Colors.white,)) ,
            //       )  
            //     ],
            //   ),
            // ),
            body:
              const Space(),
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