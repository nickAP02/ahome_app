import 'dart:convert';

import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/views/screen/device/device_list.dart';
import 'package:ago_ahome_app/views/screen/device/updated_devices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:ago_ahome_app/utils/constant.dart';
class CapteurView extends StatefulWidget {
   dynamic id;
   dynamic state;
   CapteurView(this.id,this.state, {Key? key}) : super(key: key);

  @override
  State<CapteurView> createState() => _CapteurViewState();
}

class _CapteurViewState extends State<CapteurView> {
  final  _formKey = GlobalKey<FormState>();
  Capteur capteur = Capteur("","",[]);
  bool selected=true;
  String ?valSelectionneCat;
  String ?valSelectionneP;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    var roomProvider = Provider.of<RoomProvider>(context,listen: false);
    int index =0;
    return SimpleDialog(
      title: const Text("Enregistrement d'un capteur"),
      contentPadding: const EdgeInsets.all(10),
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.4,
          constraints: const BoxConstraints(maxHeight: 500,minHeight: 250,maxWidth: 800,minWidth: 500),
          child: Form(
          key: _formKey,
          child: Column(
            children: [
              roomProvider.room!.isEmpty?Text("Les pièces ne sont pas disponibles"):Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                    hint: Text("Pièce"),
                    value: valSelectionneP,
                    items: List.generate(roomProvider.room!.length, (index) => DropdownMenuItem<String>(
                        value:roomProvider.room![index].nameRoom,
                        child: Row(
                          children: [
                            Text(roomProvider.room![index].nameRoom),
                          ],
                        ))
                      ).toList(),
                      onChanged: (value){
                      setState(() {
                        valSelectionneP = value;
                        debugPrint(valSelectionneP);
                        capteur.nameRoom =  valSelectionneP!;
                      });
                    }),
                ),
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        debugPrint("capteur id "+widget.id.toString());
                        debugPrint("capteur state "+widget.id.toString());
                        debugPrint("capteur name "+capteur.nameRoom.toString());
                        capteur.id = widget.id.toString();
                        capteur.state = widget.state;
                        capteurProvider.addCapteur(capteur);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeviceList()));
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
  @override
  void dispose() {
    super.dispose();
  }
}