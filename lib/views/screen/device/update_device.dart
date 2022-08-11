import 'dart:convert';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/model/device.dart';
// import 'package:ago_ahome_app/views/screen/device/device_list.dart';
import 'package:ago_ahome_app/views/screen/device/updated_devices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:ago_ahome_app/utils/constant.dart';
class UpdateDevice extends StatefulWidget {
   dynamic id;
   dynamic state;
   UpdateDevice(this.id,this.state, {Key? key}) : super(key: key);

  @override
  State<UpdateDevice> createState() => _UpdateDeviceState();
}

class _UpdateDeviceState extends State<UpdateDevice> {
  final  _formKey = GlobalKey<FormState>();
  Device newDevice =  Device(idDev: "",nameDev: "",puissance: 0,conso: 0,state:[0],room: "");
  // Device newDevice =  Device(idDev: "",nameDev:"",state:[],categorie: "",puissance: 0, conso:0,dateConso:DateTime.now(),room:"");
  bool selected=true;
  final server = WebSocketChannel.connect(Uri.parse("ws://192.168.1.105:5000/api/v1/device/allumerEteindre/"));
  String ?valSelectionneCat;
  String ?valSelectionneP;
  var deviceProvider;
  var roomProvider;
  @override
  void initState() {
    // int index = 0;
    deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    roomProvider  = Provider.of<RoomProvider>(context,listen: false);
    //  valSelectionne =RoomProvider().room![index].nameRoom;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    
    int index =0;
    return SimpleDialog(
      title: const Text("Modification de l'appareil"),
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
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Nom de l'appareil"
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez le champ nom';
                  }
                  else{
                    newDevice.nameDev = value.toString();
                  }
                    return null;
                  },
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                //width: 100,
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Puissance(en W)"
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez la puissance';
                    }
                    else{
                      newDevice.puissance = double.tryParse(value)!;
                    }
                  return null;
                  },
                ),
              ),
           
              roomProvider.room.isEmpty?const Text("Les pièces ne sont pas disponibles"):Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                    hint:const Text("Pièce"),
                    value: valSelectionneP,
                    items: List.generate(roomProvider.room.length, (index) => DropdownMenuItem<String>(
                        value:roomProvider.room[index].nameRoom,
                        child: Row(
                          children: [
                            Text(roomProvider.room[index].nameRoom),
                          ],
                        ))
                      ).toList(),
                      onChanged: (value){
                      setState(() {
                        valSelectionneP = value;
                        debugPrint(valSelectionneP);
                        newDevice.room =  valSelectionneP!;
                      });
                    }),
                ),
                Row(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        debugPrint("widget id "+widget.id.toString());
                        newDevice.idDev = widget.id.toString();
                        newDevice.state = widget.state;
                        var req = await deviceProvider.addDevice(newDevice);
                        if(req["statut"]==200){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DevicesUpdated()));
                        }
                        else{
                           ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(req["result"],style: TextStyle(color: Colors.red),)));
                          // Text(req["result"]);
                        }
                        
                      }
                      // server.sink.add(newDevice);
                    }, 
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
                    child: const Text("Enregistrer")
                ),
                ),
                  ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                  }, 
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                  child: const Text("Annuler")
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
  void allumerEteindre(msg){
    debugPrint(msg);
    server.sink.add(msg);
  }
  @override
  void dispose() {
    super.dispose();
  }
}