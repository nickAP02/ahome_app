// import 'package:ago_ahome_app/model/capteur.dart';
// import 'package:ago_ahome_app/model/device.dart';
import 'dart:convert';

import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
// import 'package:ago_ahome_app/views/screen/capteur/capteur_view.dart';
// import 'package:ago_ahome_app/views/screen/device/delete_device.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:ago_ahome_app/views/screen/device/device_view.dart';
import 'package:ago_ahome_app/views/screen/device/update_device.dart';
// import 'package:ago_ahome_app/views/screen/device/update_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class DevicesUpdated extends StatefulWidget {
  DevicesUpdated();

  @override
  State<DevicesUpdated> createState() => _DevicesUpdatedState();
}

class _DevicesUpdatedState extends State<DevicesUpdated> {
  int selected = 0;
  int index =0;
  final  _formKey = GlobalKey<FormState>();
  var capteurProvider;
  var roomProvider;
  String ?valSelectionneCat;
  String ?valSelectionneP;
  bool _isSelected = true;
  final server = WebSocketChannel.connect(Uri.parse("ws://192.168.1.105:5000/api/v1/device/allumerEteindre/"));
  void initState() {
    var capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    var roomProvider = Provider.of<RoomProvider>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    var capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des appareils"),),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
           deviceProvider.namedDevices.isEmpty?
           const Center(
            child: CircularProgressIndicator(color: kPrimaryColor,semanticsLabel: "Chargement des données",),
            )
           :ListView.builder(
            // padding: EdgeInsets.all(5),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Provider.of<DeviceProvider>(context,listen:false).getNamedDevices().length,
            itemBuilder: (context, index)=>
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder:(context)=>UpdateDevice(
                      Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].idDev,  
                      Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].state)
                      )
                    );
                },
                onLongPress: (){
                  
                },
                child: Container(
                  height: MediaQuery.of(context).size.height/5,
                  width:  MediaQuery.of(context).size.width/8,
                  child: DeviceCard(
                       '${Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].nameDev}',
                       Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].conso!.toDouble(),
                       Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].state,
                       Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].idDev 
                    ),
                ),
              )
            //separatorBuilder: (_,index)=>SizedBox(width: 20)
          ),
         
          capteurProvider.namedCapteurs.isEmpty?const Center(child: CircularProgressIndicator(color: kPrimaryColor,),):ListView.builder(
              padding:const EdgeInsets.all(5),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs().length,
              itemBuilder: (context,index)=>GestureDetector(
                onLongPress: (){
                  showDialog(context: context, builder: (BuildContext buildContext){
                        return  AlertDialog(
                          title: const Text("Voulez vous supprimer ce capteur ?",style: TextStyle(color: Colors.red),),
                            contentPadding: const EdgeInsets.all(10),
                            content:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:18.0),
                                    child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                    onPressed: () async{
                                      var request = await roomProvider.deleteCapteur(Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index]);
                                      if(request["statut"]==200){
                                        setState(() {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(request["result"])));
                                          Navigator.of(context).pop();
                                        });
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(request["result"])));
                                      }
                                    },
                                    child: const Text('Oui'),
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                                  child: const Text("Non")
                                  ),
                                ],
                              )
                           );
                  });
                },
                onTap: (){
                  setState(() {
                    selected = index;
                  });
                   SimpleDialog(
                    title: const Text("Modification d'un capteur"),
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
                                items: List.generate(roomProvider.room["result"].length, (index) => DropdownMenuItem<String>(
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
                                    Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].nameRoom =  valSelectionneP!;
                                  });
                                }),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                
                                  onPressed: (){
                                  setState(() {
                                      if(Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].state[0]==0){
                                        Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].state[0]=1;
                                        Map<String,dynamic> msg = {
                                          "id":"${Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].id}",
                                          "state":Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].state
                                        };
                                        allumerEteindre(jsonEncode(msg));
                                      }
                                      else{
                                        Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].state[0]=0;
                                        Map<String,dynamic> msg = {
                                          "id":"${Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].id}",
                                          "state":Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index].state
                                        };
                                        allumerEteindre(jsonEncode(msg));
                                      }
                                      // debugPrint("element 1 state "+widget.state[0].toString()+" element 2 state "+widget.state[1].toString()+" element 3 state "+widget.state[2].toString());
                                      
                                    // debugPrint("element 1 state "+widget.state[0].toString());
                                    // allumerEteindre(jsonEncode(msg));
                                  });
                                }, 
                                  style: _isSelected ?ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)):ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                                  child: const Text("Tester")
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ElevatedButton(
                                    onPressed: () async{
                                    if(_formKey.currentState!.validate()){
                                      dynamic req =  await capteurProvider.addCapteur(Provider.of<CapteurProvider>(context,listen:false).getNamedCapteurs()[index]);
                                      debugPrint("request "+req.toString());
                                      if(req["statut"]==200){
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

                },
                child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  color: selected==index?kPrimaryColor:  Colors.white,
                ),
                child:Text(
                  'Capteur '+'${Provider.of<CapteurProvider>(context,listen:false).capteur![index].id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ), 
          )
        ],
      ),
      // floatingActionButton: SpeedDial(
      //   activeBackgroundColor: kPrimaryColor,
      //   backgroundColor: kBackground,
      //   child: IconButton(
      //   highlightColor: kPrimaryColor,
      //   icon:const Icon(Icons.add),
      //   onPressed: (){
      //     showDialog(context: context, builder: (BuildContext build){
      //       return  DeviceView(Provider.of<DeviceProvider>(context,listen:false).getNamedDevices()[index].idDev,Provider.of<DeviceProvider>(context,listen:true).getNamedDevices()[index].state);
      //     });
      //   },
      //   ),
      // )
    );
  }
  void allumerEteindre(msg){
    debugPrint(msg);
    server.sink.add(msg);
  }
  @override
  void dispose() {
    
    // TODO: implement dispose
    super.dispose();
  }
}