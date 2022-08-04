// ignore_for_file: sized_box_for_whitespace

// import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
// import 'package:ago_ahome_app/utils/constant.dart';
// import 'package:ago_ahome_app/views/screen/device/device_card.dart';
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
    var roomProvider = Provider.of<RoomProvider>(context,listen: true);
    bool expanded = false;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) =>GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children:[]
          )
        );
  }

}