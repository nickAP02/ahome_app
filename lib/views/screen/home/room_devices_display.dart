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
            (index) => DeviceCard(room["appareils"][index]["name"], room["appareils"][index]["conso"], room["appareils"][index]["state"], room["appareils"][index]["id"])
            );
            debugPrint(value.toString());
    // int index =0;
    // var capteurProvider = Provider.of(context)<CapteurProvider>(context,listen:false);
    // var roomProvider = Provider.of(context)<RoomProvider>(context,listen:false);
    // debugPrint("liste app "+room["appareils"].toString());
    return room/*[index]*/["appareils"].isEmpty?Center(child: Text("Pas d'appareils dispo")):Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Padding(padding: EdgeInsets.only(left: 50)),
        // Text(room.toString()),
         Row(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              Text("Consommation "),
              Text("${2}"),
              Text(" kWh"),
            ],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          
          children: [
            
            Text("${Provider.of<RoomProvider>(context,listen: true).roomOnDevices.length}"),
            Text(" appareils"),
            Text(" allumés"),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: const EdgeInsets.symmetric(horizontal: 25),
          child: GridView.count(
              crossAxisCount: 2,
              children: value,
          )
        ),
      ],
    );
  }
}