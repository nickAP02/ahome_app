import 'dart:convert';
// import 'package:ago_ahome_app/services/providers/device_provider.dart';
// import 'package:ago_ahome_app/services/providers/room_provider.dart';
// import 'package:ago_ahome_app/utils/colors.dart';
// import 'package:ago_ahome_app/model/device.dart';
// import 'package:ago_ahome_app/views/screen/device/device_list.dart';
import 'package:ago_ahome_app/views/screen/device/updated_devices.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:ago_ahome_app/utils/constant.dart';
class DeleteDevice extends StatefulWidget {
   dynamic room;
  //  dynamic categorie;
   dynamic nameDev;
   dynamic conso;
   
   DeleteDevice(this.room,this.nameDev,this.conso);

  @override
  State<DeleteDevice> createState() => _DeleteDeviceState();
}

class _DeleteDeviceState extends State<DeleteDevice> {
  final  _formKey = GlobalKey<FormState>();
  
  bool selected=true;
  String ?valSelectionneCat;
  String ?valSelectionneP;
  @override
  void initState() {
    debugPrint('data '+widget.toString());
    // int index = 0;
    //  valSelectionne =RoomProvider().room![index].nameRoom;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    // var roomProvider = Provider.of<RoomProvider>(context,listen: false);
    int index =0;
    return SimpleDialog(
      title: const Text("Suppression de l'appareil",style: TextStyle(color: Colors.red),),
      contentPadding: const EdgeInsets.all(10),
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.4,
          constraints: const BoxConstraints(maxHeight: 500,minHeight: 250,maxWidth: 800,minWidth: 500),
          child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                //width: 100,
                child:const Text('dummy text')
              ),
              // Container(
              //   alignment: Alignment.topCenter,
              //   //width: 100,
              //   child: Text(widget.deleteDevice.puissance!.toDouble().toString()),
              // ),
              // Container(
              //   alignment: Alignment.topCenter,
              //   //width: 100,
              //   child: Text(widget.deleteDevice.categorie.toString()),
              // ),
              //  Container(
              //   alignment: Alignment.topCenter,
              //   //width: 100,
              //   child: Text(widget.deleteDevice.room.toString()),
              // ),
              //liste des categories fixes
             
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        // deviceProvider.device!.removeAt(index).idDev;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DevicesUpdated()));
                      }
                      // server.sink.add(newDevice);
                    }, 
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                    child: const Text("Oui")
                ),
                ),
                  ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                  }, 
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                  child: const Text("Non")
                )
                ],
              )
          ],
          ),
        ),
      )
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}