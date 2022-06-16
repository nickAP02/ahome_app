import 'dart:convert';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/views/device_card.dart';
import 'package:ago_ahome_app/views/device_view.dart';
import 'package:ago_ahome_app/views/room_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   
    List<Room> rooms = [
    ];
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
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
          ),
          //primarySwatch: Color.fromRGBO(247, 248, 250, 1),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title:const Text('AGO AHOME'),
            //leading: const Icon(Icons.menu),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12,
                horizontal: 16),
                child: CircleAvatar(
                  maxRadius: 15,
                  backgroundImage: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
                ),),
            ],
          ),
          drawer: Drawer(
            backgroundColor: const Color.fromRGBO(20,115,209,1),
            elevation:300,
            width: 100,
            child: ListView(
              children: [
                ListTile(
                  subtitle: const Text("Accueil",
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  leading: IconButton(
                    icon:const Icon(Icons.home,color: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const MyHomePage()));
                    },
                  ),
                ),
                ListTile(
                  subtitle: const Text("Pièces", 
                  style:TextStyle(color:Colors.white)
                  ),
                  leading: IconButton(
                    icon:const Icon(Icons.meeting_room_outlined,color: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const RoomDevice()));
                    },)
                  ),
                ListTile(
                  subtitle: const Text("Appareils",
                  style:TextStyle(color:Colors.white)
                  ),
                  leading: IconButton(
                    icon:const Icon(Icons.devices,color: Colors.white,),
                    onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const DeviceView()));
                    },
                    )
                  ),
                ListTile(
                  leading:IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.logout,color: Colors.white,)) ,
                )  
              ],
            ),
          ),
          body: 
            SingleChildScrollView(
              child: Column(
                children: [
                  
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children:const [
                      DeviceCard(),
                      DeviceCard(),
                      DeviceCard(),
                      DeviceCard()
                    ],
                ),
               ),
                      ],
                    ),
            ),
      ),
    );
  }
  //creer container
  //crer une colonne pour le bouton et le text
  //inserer un row dans le container
  //
  @override
  void dispose(){
      super.dispose();
  }
}