import 'dart:convert';

import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/device/updated_devices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class CapteurView extends StatefulWidget {
   dynamic id;
   dynamic state;
   CapteurView(this.id,this.state, {Key? key}) : super(key: key);

  @override
  State<CapteurView> createState() => _CapteurViewState();
}

class _CapteurViewState extends State<CapteurView> {
  final  _formKey = GlobalKey<FormState>();
  Capteur capteur = Capteur(id:"",nameRoom: "",state:[]);
  bool selected=true;
  String ?valSelectionneCat;
  String ?valSelectionneP;
  final server = WebSocketChannel.connect(Uri.parse("ws://192.168.0.106:5000/api/v1/device/allumerEteindre/"));
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var capteurProvider=Provider.of<CapteurProvider>(context,listen:true);
    var roomProvider = Provider.of<RoomProvider>(context,listen: true);
    int index =0;
    return SimpleDialog(
      title: const Text("Enregistrement d'un capteur"),
      contentPadding: const EdgeInsets.all(10),
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.1,
          constraints: const BoxConstraints(maxHeight: 500,minHeight: 250,maxWidth: 800,minWidth: 500),
          child: Form(
          key: _formKey,
          child: Column(
            children: [
              // roomProvider.room.isEmpty?const Text("Les pièces ne sont pas disponibles"):
              Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                    hint:const Text("Pièce"),
                    value: valSelectionneP,
                    items: List.generate(roomProvider.room.length, (index) => DropdownMenuItem<String>(
                        value:roomProvider.room[index]["name"],
                        child: Row(
                          children: [
                            Text(roomProvider.room[index]["name"]),
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
                    ElevatedButton(
                      // // onLongPress: (){
                      // //   setState(() {
                      // //     debugPrint("state "+widget.state);
                      // //       Map<String,dynamic> msg = {
                      // //     "id":"${widget.id}",
                      // //     "state":widget.state
                      // //     };
                      // //   allumerEteindre(jsonEncode(msg));
                      // //   //  msg = jsonEncode(id,state)
                      // //   // allumerEteindre();
                      // //   });
                      // },
                      onPressed: (){
                       setState(() {
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
                        // allumerEteindre(jsonEncode(msg));
                       });
                    }, 
                      style: selected ?ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)):ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                      child: const Text("Tester")
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        onPressed: (){
                        if(_formKey.currentState!.validate()){
                          debugPrint("widget id "+widget.id.toString());
                          capteur.id = widget.id.toString();
                          capteur.state = widget.state;
                          var req =  capteurProvider.addCapteur(capteur);
                          debugPrint("request "+req.toString());
                          if(req[1]["statut"]==200){
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(req["result"],style: TextStyle(color: Colors.white))));
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DevicesUpdated()));

                            });
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(req["result"],style: TextStyle(color: Colors.red),)));
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