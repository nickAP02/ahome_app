import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
class DeviceCard extends StatefulWidget {
  //  late Device device;
  // late  String name;
  // late double conso;
  // DeviceCard(this.name,this.conso);
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
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     var roomProvider=Provider.of<RoomProvider>(context,listen:false);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
          onTap: (){
            setState(() {
              _isSelected = !_isSelected;
              colorOn = true;
              textColor = textColor;
            });
          },
          onTapCancel: (){
            setState(() {
              _isSelected = !_isSelected;
              colorOn =  false;
              textColor = Colors.black;
            });
          },
          child: Container(
            height:50,
            width: 100,
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
                        
                Icon(Icons.lightbulb_outline,color:_isSelected?textColor:Colors.black),
                
                roomProvider.devices.isEmpty? Text('Appareil', 
                  style: TextStyle(
                    color:_isSelected?textColor:Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ):Text('${roomProvider.devices[index].nameDev}', 
                  style: TextStyle(
                    color:_isSelected?textColor:Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
                roomProvider.devices.isEmpty? Text('0 kwh', 
                  style: TextStyle(
                    color:_isSelected?textColor:Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ):Text('${roomProvider.devices[index].puissance} kwh', 
                  style: TextStyle(
                    color:_isSelected?textColor:Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
              ],
              )
            ),
          ),
        );
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
