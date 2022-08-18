import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoomDetail extends StatefulWidget {
  dynamic room;
  RoomDetail(this.room);

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  @override
  Widget build(BuildContext context) {
    var value = List.generate(
      widget.room["appareils"],(index){
        return DeviceCard(
          widget.room["appareils"]["name"],
          widget.room["appareils"]["conso"], 
          widget.room["appareils"]["state"], 
          widget.room["appareils"]["id"]
        );
      }
    );
    return Scaffold(
      appBar: AppBar(title: widget.room["name"],),
      body: SingleChildScrollView(
        child: GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children: value,
        ),
      ),
    );
  }
}