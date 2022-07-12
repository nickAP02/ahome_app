import 'package:ago_ahome_app/utils/constant.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';

class CategoryDevice extends StatefulWidget {
  const CategoryDevice({Key? key}) : super(key: key);

  @override
  State<CategoryDevice> createState() => _CategoryDeviceState();
}

class _CategoryDeviceState extends State<CategoryDevice> {
  @override
  Widget build(BuildContext context) {
    final bool isExpanded = false;
    return ExpansionPanelList(
      expansionCallback: ((panelIndex, isExpanded) {
        setState(() {
          isExpanded = !isExpanded;
        });
      }),
      children: categorieDevice.
      map((e) => ExpansionPanel(
        isExpanded: isExpanded,
        headerBuilder: (context,isExpanded){
        return ListTile(
          title: Text(e['categorie']),
          //subtitle: Text(isExpanded.toString()),
        );}, 
        body:DeviceCard()
        )
      ).toList()
    );
  }
}