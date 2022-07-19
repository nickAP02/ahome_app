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
        
        isExpanded: isExpanded==isExpanded?false:true,
        headerBuilder: (context,isExpanded){
          debugPrint(isExpanded.toString());
        return Row(
          children: [
              Image.asset(e['icone']),
              Text(e['categorie']),
            ],
          );
        }, 
        body:Container(
          height: 800,
          width: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return DeviceCard();
              },
              itemCount: 5,
            ),
          ),
        )
        )
      ).toList()
    );
  }
}