import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
    // var capteurProvider = Provider.of(context)<CapteurProvider>(context,listen:false);
    // var roomProvider = Provider.of(context)<RoomProvider>(context,listen:false);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height/2,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
        controller: pageController,
        onPageChanged: (index)=>callback(index),
        children:
          room.map<Widget>(
            // (element) => Text(element.nameDev)
            (element)=>Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Text("Consommation "),
                    Text("${0.5}"),
                    Text(" kWh"),
                  ],
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Text("Temperature "),
                    Text("${12}"),
                    Text(" °C"),
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
                DeviceCard(element.nameDev, element.conso, element.state, element.idDev),
              ],
            )
          ).toList()
        ,
      ),
    );
  }
}