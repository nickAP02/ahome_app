// import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
// import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
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
    
    int index =0;
    // var capteurProvider = Provider.of(context)<CapteurProvider>(context,listen:false);
    // var roomProvider = Provider.of(context)<RoomProvider>(context,listen:false);
    return room/*[index]*/["appareils"].isEmpty?Center(child: Text("Pas d'appareils dispo")):Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Padding(padding: EdgeInsets.only(left: 50)),
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
            
            Text("${2}"),
            Text(" appareils"),
            Text(" allumés"),
          ],
        ),
        Container(
          height: 200,
          width: 200,
          // padding: const EdgeInsets.symmetric(horizontal: 25),
          child: PageView(
            controller: pageController,
            onPageChanged: (index)=>callback(index),
            children:
              room/*[index]*/["appareils"].map<Widget>(
                // (element) => Text(element.nameDev)
                (element)=>DeviceCard(element["name"], element["conso"], element["state"], element["id"])
              ).toList()
            ,
          ),
        ),
      ],
    );
  }
}