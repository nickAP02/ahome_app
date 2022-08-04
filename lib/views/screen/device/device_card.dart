import 'dart:convert';

import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
class DeviceCard extends StatefulWidget {
  dynamic state;
  dynamic id;
  String name;
  double conso;
  DeviceCard(this.name,this.conso,this.state,this.id);
  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  int index=0;
  bool _isSelected = false;
  bool switchVal = false;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  var colorOn = false;
  var textColor = Colors.white;
  final server = WebSocketChannel.connect(Uri.parse("ws://192.168.1.110:5000/api/v1/device/allumerEteindre/"));
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // var roomProvider = Provider.of<RoomProvider>(context,listen: true);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
        onTap: (){
          setState(() {
            _isSelected = !_isSelected;
            colorOn = true;
            textColor = textColor;
           if(widget.state[0]==0){
              widget.state[0]=1;
              Map<String,dynamic> msg = {
                "id":"${widget.id}",
                "state":widget.state
              };
              allumerEteindre(jsonEncode(msg));
            }
            else{
              widget.state[0]=0;
              Map<String,dynamic> msg = {
                "id":"${widget.id}",
                "state":widget.state
              };
              allumerEteindre(jsonEncode(msg));
            }
            // debugPrint("element 1 state "+widget.state[0].toString()+" element 2 state "+widget.state[1].toString()+" element 3 state "+widget.state[2].toString());
            
          // debugPrint("element 1 state "+widget.state[0].toString());
            
          });
        },
        child: Container(
          height:150,
          width: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isSelected?kPrimaryColor:Colors.white,
            borderRadius: BorderRadius.circular(20)),
              //color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RotatedBox(
                  quarterTurns:135,
                  child:Switcher(
                    switcherButtonBoxShape: BoxShape.circle,
                    enabledSwitcherButtonRotate: true,
                    switcherButtonAngleTransform: 90,
                    value: false,
                    colorOff: colorOn?const Color.fromRGBO(255, 255, 255, 0.5):tapColor,
                    iconOn: Icons.circle_outlined,
                    iconOff: Icons.circle_outlined,
                    colorOn: colorOn?tapColor:const Color.fromRGBO(255, 255, 255, 0.5),
                    size: SwitcherSize.small,
                    onChanged: (switchVal){
                      switchVal = !switchVal;
                      colorOn = !colorOn;
                    }
                  ),
                  ),
                ],
              ),
              
             Text(widget.name, 
                style: TextStyle(
                  color:_isSelected?textColor:Colors.black,
                  fontWeight: FontWeight.bold
                )
              ),
              Text('${widget.conso}'+' kwh', 
                style: TextStyle(
                  color:_isSelected?textColor:Colors.black,
                  fontWeight: FontWeight.bold
                )
              )
            ],
            )
          ),
        ),
      );
   }
   void allumerEteindre(msg){
    debugPrint(msg);
    server.sink.add(msg);
  }

  @override
  void dispose(){
    super.dispose();
  }
}
