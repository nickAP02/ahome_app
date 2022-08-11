import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/device/device_list.dart';
import 'package:ago_ahome_app/views/screen/room/room_view.dart';
import 'package:ago_ahome_app/views/screen/planning/planning_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFloatingActionBtn extends StatelessWidget {
  const CustomFloatingActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      visible: true,
      backgroundColor: kBackground,
      animatedIcon: AnimatedIcons.add_event,
      overlayOpacity: 0.4,
      children: [
        SpeedDialChild(
          labelStyle: const TextStyle(fontSize: 20),
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.devices,color: Colors.white,),
          label: "Ajouter un appareil",
          onTap: ()=>showDialog(
            barrierDismissible: false,
            context: context, 
            builder: (BuildContext builder){
            return DeviceList();
          })
        ),
        SpeedDialChild(
          labelStyle: const TextStyle(fontSize: 20),
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.bed,color: Colors.white,),
          label: "Ajouter une pièce",
          onTap: ()=>showDialog(
            barrierDismissible: false,
            context: context, 
            builder: (BuildContext builder){
            return const RoomDevice();
            })
        ),
        SpeedDialChild(
          labelStyle: const TextStyle(fontSize: 20),
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.event,color: Colors.white,),
          label: "Ajouter un planning",
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PlanningView()))
        )
      ],
    );
  }
}