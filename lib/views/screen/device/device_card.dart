import 'dart:convert';

import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
class DeviceCard extends StatefulWidget {
  dynamic? state;
  dynamic? id;
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
  final server = WebSocketChannel.connect(Uri.parse("ws://127.0.0.1:5000/api/v1/device/allumerEteindre/"));
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
            }
            else{
              Text("L'appareil est déjà allumé");
            }
            // debugPrint("element 1 state "+widget.state[0].toString()+" element 2 state "+widget.state[1].toString()+" element 3 state "+widget.state[2].toString());
            Map<String,dynamic> msg = {
              "id":"${widget.id}",
              "state":widget.state
            };
            debugPrint("arrive ici 1"+msg.toString());
          allumerEteindre(jsonEncode(msg));
          // debugPrint("element 1 state "+widget.state[0].toString());
            
          });
        },
        onLongPress:(){
          setState(() {
            _isSelected = !_isSelected;
            colorOn =  false;
            textColor = Colors.black;
            
            widget.state[0]=0;
            // debugPrint("state "+widget.state);
                Map<String,dynamic> msg = {
              "id":"${widget.id}",
              "state":widget.state
              };
              debugPrint("arrive ici 2"+msg.toString());
            allumerEteindre(jsonEncode(msg));
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
              // Icon(Icons.lightbulb_outline,color:_isSelected?textColor:Colors.black),
              
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
  //   return FutureBuilder<List<Device>>(
  //     future: devices,
  //     builder: (context,snapshot){
  //       if(snapshot.hasData){
  //           return Scaffold(
  //           body: GestureDetector(
  //             onTap: (){
  //               setState(() {
  //                 _isSelected = !_isSelected;
  //                 colorOn = true;
  //               });
  //             },
  //             onTapCancel: (){
  //               setState(() {
  //                 _isSelected = !_isSelected;
  //                 colorOn =  false;
  //               });
  //             },
  //             child: Container(
  //             //color: const Color.fromRGBO(20,115,209,1),
  //               margin: const EdgeInsets.fromLTRB(20,15, 20, 0),
  //               width: MediaQuery.of(context).size.width*0.5,
  //               height:200,
  //               decoration: BoxDecoration(
  //                 color: tapColor,
  //                 border: Border.all(
  //                   width: 0.5,
  //                   color: _isSelected?tapColor:Colors.white,
  //                 ), 
  //                 borderRadius: BorderRadius.circular(25),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                     verticalDirection: VerticalDirection.down,
  //                     children: [
  //                       Stack(
  //                         alignment: AlignmentDirectional.centerStart,
  //                         children: const [
  //                           Text("Interrupteur",
  //                           maxLines: 2,
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: Colors.black87
  //                           ),
  //                         ),
        
  //                         ]
  //                       ),
  //                       RotatedBox(
  //                         quarterTurns:90,
  //                         child: Switcher(
  //                           switcherButtonBoxShape: BoxShape.circle,
  //                           enabledSwitcherButtonRotate: true,
  //                           switcherButtonAngleTransform: 90,
  //                           value: false,
  //                           colorOff: Colors.white70,
  //                           iconOn: Icons.circle_rounded,
  //                           iconOff: Icons.circle_outlined,
  //                           colorOn: colorOn? tapColor : Colors.white,
  //                           size: SwitcherSize.small,
  //                           onChanged: (switchVal){
  //                             switchVal = !switchVal;
  //                             colorOn = !colorOn;
  //                           }
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: const [
  //                       Icon(Icons.lightbulb_outline,
  //                       color: Colors.white,
  //                       )
  //                     ],
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Text(widget.name),
  //                       const SizedBox(width: 50,height: 20,),
  //                       Text("${widget.conso}",
  //                       style: const TextStyle(
  //                         color: Colors.white,
  //                         fontFamily: "MontSerrat",
  //                       ),
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //       else{
  //         return const Center(child: CircularProgressIndicator(color: Colors.blue,));
  //       }
  //     }
      
  //   );
    
  // }
  @override
  void dispose(){
    super.dispose();
  }
}
