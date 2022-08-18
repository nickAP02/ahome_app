import 'dart:convert';

import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
class DeviceCard extends StatefulWidget {
  dynamic state;
  dynamic id;
  // dynamic icone;
  String name;
  dynamic conso;
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
  final server = WebSocketChannel.connect(Uri.parse("ws://192.168.1.103:5000/api/v1/device/allumerEteindre/"));
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
            
          });
        },
        child: Container(
          height:550,
          width: 500,
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: _isSelected?kPrimaryColor:Colors.white,
              boxShadow: [
                BoxShadow(
                color:_isSelected?kPrimaryColor.withOpacity(0.2):kBackground.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3)
              )],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                // Padding(padding: EdgeInsets.only(left: 50)),
                 widget.state==1?Stack(
                  alignment: AlignmentDirectional.topStart,
                   children:[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration:BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                      child: Text(""),
                    ),
                   ]):
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                      decoration:BoxDecoration(
                        shape: BoxShape.circle,
                    //borderRadius: BorderRadius.,
                    color: Colors.red,
                      ),
                      child: Text(""),
                    ),
                    ],
                  ),
               Text(widget.name, 
                  style: TextStyle(
                    fontSize: 18,
                    color:_isSelected?textColor:Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
                widget.state[2]==1?Image.asset(
                  iconeAsset+"lightbulb.png",
                  color: _isSelected?textColor:Colors.black
                  ):Image.asset(
                  iconeAsset+"plug-power.png",
                  color: _isSelected?textColor:Colors.black
                  ),
                Text('${widget.conso.toStringAsPrecision(3)}'+' MWh', 
                  style: TextStyle(
                    fontSize: 18,
                    color:_isSelected?textColor:Colors.black,
                    fontWeight: FontWeight.bold
                  )
                )
              ],
              ),
            )
          ),
        ),
      );
   }
   void allumerEteindre(msg){
    debugPrint(msg);
    server.sink.add(msg);
  }
  //pour avoir le changement de state des devices


  @override
  void dispose(){
    super.dispose();
  }
}
