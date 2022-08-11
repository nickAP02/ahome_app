import 'package:ago_ahome_app/services/local_storage.dart';
import 'package:ago_ahome_app/services/theme_service.dart';
import 'package:ago_ahome_app/views/screen/auth/login.dart';
// import 'package:ago_ahome_app/views/screen/device/device_list.dart';
import 'package:ago_ahome_app/views/screen/device/updated_devices.dart';
import 'package:ago_ahome_app/views/screen/planning/planning_list.dart';
import 'package:ago_ahome_app/views/screen/room/room_list.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:ago_ahome_app/views/screen/stats.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading:IconButton(
              icon:const Icon(Icons.dark_mode),
              onPressed: (){
                ThemeService().switchTheme();
              },
            ),
          ),
        ),
        ListTile(
          leading: IconButton(
            icon:const Icon(Icons.home,
            size: 40,
            color: Colors.white,
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const Home()));
            },
            
          ),
          // subtitle: const Text("Accueil",
          // style: TextStyle(
          //   color: Colors.white,
          // ),),
          
        ),
        const Align(
          alignment: Alignment.center,
          child: Text("Accueil",
              style: TextStyle(
                color: Colors.white,
              ),),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            // subtitle: const Text("Pièces", 
            // style:TextStyle(color:Colors.white)
            // ),
            leading: IconButton(
              icon:const Icon(
                Icons.apartment,
                color: Colors.white,
                size: 40,
                ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const Rooms()));
              },)
            ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text("Pièces",
              style: TextStyle(
                color: Colors.white,
              ),),
        ),
        const SizedBox(height: 10,),
        ListTile(
          leading: IconButton(
            icon:const Icon(Icons.device_hub,
            color: Colors.white,
            size: 40,),
            onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>  DevicesUpdated()));
            }
          )
        ),
        const SizedBox(height: 10,),
        const Align(
          alignment: Alignment.center,
          child: Text("Appareils",
              style: TextStyle(
                color: Colors.white,
              ),),
        ),
        const SizedBox(height: 10,),
        ListTile(
          leading: IconButton(
            icon:const Icon(Icons.calendar_month,
            color: Colors.white,
            size: 40,),
            onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Plannings()));
            }
          )
        ),
        const SizedBox(height: 10,),
        const Align(
          alignment: Alignment.center,
          child: Text("Plannification",
              style: TextStyle(
                color: Colors.white,
              ),),
        ),
        // const SizedBox(height: 10,),
        // ListTile(
        //   leading: IconButton(
        //     icon:const Icon(Icons.bar_chart_sharp,
        //     color: Colors.white,
        //     size: 40,),
        //     onPressed: (){
        //     Navigator.of(context).push(MaterialPageRoute(
        //       builder: (BuildContext context) =>  const Statistic()));
        //     }
        //   )
        // ),
        // const SizedBox(height: 10,),
        // const Align(
        //   alignment: Alignment.center,
        //   child: Text("Statistiques",
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),),
        // ),
        const SizedBox(height: 50,),
        ListTile(
          leading:IconButton(onPressed: (){
            LocalStorage().logout();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>  const Login()));

          }, icon: const Icon(Icons.logout,
          color: Colors.white,
          size: 40,
          )
          ) ,
        )  
      ],
    );
  }
}