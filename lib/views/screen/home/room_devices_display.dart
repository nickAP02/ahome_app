// import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
// import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


class RoomDevicesDisplay extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final List<dynamic> room;
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
    return room[index].appareils.isEmpty?Center(child: Text("Pas d'appareils dispo")):Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height/2,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
        controller: pageController,
        onPageChanged: (index)=>callback(index),
        children:
          room[index].appareils.map<Widget>(
            // (element) => Text(element.nameDev)
            (element)=>Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: const[
                    Text("Consommation "),
                    Text("${0.5}"),
                    Text(" kWh"),
                  ],
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: const[
                    Text("Temperature "),
                    Text("${12}"),
                    Text(" °C"),
                  ],
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  
                  children: const[
                    Text("${2}"),
                    Text(" appareils"),
                    Text(" allumés"),
                  ],
                ),
                DeviceCard(element.nameDev, element.conso, element.state, element.idDev),
              ],
            )
          ).toList()
        ,
      ),
    );
  }
}