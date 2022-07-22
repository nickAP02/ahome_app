// ignore_for_file: sized_box_for_whitespace

import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDevice extends StatefulWidget {
  const CategoryDevice({Key? key}) : super(key: key);

  @override
  State<CategoryDevice> createState() => _CategoryDeviceState();
}

class _CategoryDeviceState extends State<CategoryDevice> {
  
  @override
  Widget build(BuildContext context) {
    var roomProvider= Provider.of<RoomProvider>(context,listen: false);
    bool isExpanded = false;
    return ExpansionPanelList(
      expansionCallback: ((panelIndex, isExpanded) {
        setState(() {
          isExpanded = isExpanded;
          debugPrint(isExpanded.toString());
        });
      }),
      children: categorieDevice.
      map((e) => ExpansionPanel(
        
        isExpanded: isExpanded==isExpanded?true:false,
        headerBuilder: (context,isExpanded){
          debugPrint(isExpanded.toString());
        return Row(
          children: [
              Image.asset(e['icone']),
              Text(e['categorie']),
            ],
          );
        }, 
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children:[
              DeviceCard(),
              DeviceCard(),
              DeviceCard(),
              DeviceCard(),
              DeviceCard()
            ],
          ),
        )
        )
      ).toList()
    );
  }
}