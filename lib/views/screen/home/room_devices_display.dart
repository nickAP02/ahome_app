// import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
// import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';


class RoomDevicesDisplay extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final dynamic room;
  const RoomDevicesDisplay(
    this.selected,
    this.callback,
    this.pageController,
    this.room
  );
  
  @override
  Widget build(BuildContext context) {
    // var roomProvider= Provider.of<RoomProvider>(context,listen: true);
    var value = List.generate(
            room["appareils"].length, 
            (index){
              if(room["appareils"][index]["state"][0]==0){
                  return DeviceCard(
                room["appareils"][index]["name"],
                0, 
                room["appareils"][index]["state"], 
                room["appareils"][index]["id"]);
              }
              else{
                return DeviceCard(
              room["appareils"][index]["name"],
              room["appareils"][index]["conso"], 
              room["appareils"][index]["state"], 
              room["appareils"][index]["id"]);
              }
              
            }
            );
            debugPrint(value.toString());
    // int index =0;
    // var capteurProvider = Provider.of(context)<CapteurProvider>(context,listen:false);
    // var roomProvider = Provider.of(context)<RoomProvider>(context,listen:false);
    // debugPrint("liste app "+room["appareils"].toString());
    return room/*[index]*/["appareils"].isEmpty?Center(child: Text("Pas d'appareils dispo")):Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Padding(padding: EdgeInsets.only(left: 50)),
        // Text(room.toString()),
        Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                children: value,
            ),
          )
        ),
      ],
    );
  }
}