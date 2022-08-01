import 'dart:convert';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/views/screen/device/updated_devices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:ago_ahome_app/utils/constant.dart';
class DeviceView extends StatefulWidget {
   dynamic id;
   dynamic state;
   DeviceView(this.id,this.state, {Key? key}) : super(key: key);

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  final  _formKey = GlobalKey<FormState>();
  Device newDevice =  Device(idDev: "",nameDev: "",categorie: "",puissance: 0,conso: 0,state: [0],room: "");
  // Device newDevice =  Device(idDev: "",nameDev:"",state:[],categorie: "",puissance: 0, conso:0,dateConso:DateTime.now(),room:"");
  bool selected=true;
  final server = WebSocketChannel.connect(Uri.parse("ws://127.0.0.1:5000/api/v1/device/allumerEteindre/"));
  String ?valSelectionneCat;
  String ?valSelectionneP;
  TextEditingController _puissanceController = TextEditingController();
  TextEditingController _nameDevController = TextEditingController();
  // TextEditingController _pController = TextEditingController();
  @override
  void initState() {
    // int index = 0;
    //  valSelectionne =RoomProvider().room![index].nameRoom;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    var roomProvider = Provider.of<RoomProvider>(context,listen: false);
    int index =0;
    return WillPopScope(
       onWillPop: ()async{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Impossible de retourner en arrière")));
        return false;
      },
      child: SimpleDialog(
        title: const Text("Enregistrement de l'appareil"),
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
                    controller: _nameDevController,
                    decoration: const InputDecoration(
                      hintText: "Nom de l'appareil"
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le champ nom';
                    }
                    else{
                      value = _nameDevController.text;
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
                    controller: _puissanceController,
                    decoration: const InputDecoration(
                      hintText: "Puissance(en W)"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez la puissance';
                      }
                      else{
                        value = _puissanceController.text;
                        newDevice.puissance = double.tryParse(value)!;
                      }
                    return null;
                    },
                  ),
                ),
                //liste des categories fixes
               categorieDevice.isEmpty?const Text("Les catégories ne sont pas disponibles"):Container(
                height: 50,
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<String>(
                        hint: const Text("Catégorie"),
                        value: valSelectionneCat,
                        items: categorieDevice.
                        map((e) => 
                          DropdownMenuItem<String>(
                            value:e['categorie'],
                            child: Row(
                              children: [
                                //Text(e['icone']),
                                Text(e['categorie']),
                              ],
                            ))
                          ).toList(),
                          onChanged: (value){
                          setState(() {
                            valSelectionneCat = value;
                            newDevice.categorie =  valSelectionneCat!;
                            newDevice.conso = 0.0;
                          });
                        }
                       ),
                ),
                // modifier pour afficher la liste des pieces
                roomProvider.room.isEmpty?
                Text("Les pièces ne sont pas disponibles"):Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                      hint: Text("Pièce"),
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
                    ElevatedButton(
                      onLongPress: (){
                        setState(() {
                          debugPrint("state "+widget.state);
                            Map<String,dynamic> msg = {
                          "id":"${widget.id}",
                          "state":"${widget.state}"
                          };
                        allumerEteindre(jsonEncode(msg));
                        //  msg = jsonEncode(id,state)
                        // allumerEteindre();
                        });
                      },
                      onPressed: (){
                       setState(() {
                          if(widget.state[0]==0){
                            widget.state[0]=1;
                          }
                          else{
                            Text("L'appareil est déjà allumé");
                          }
                          debugPrint("element 1 state "+widget.state[0].toString()+" element 2 state "+widget.state[1].toString()+" element 3 state "+widget.state[2].toString());
                          Map<String,dynamic> msg = {
                          "id":"${widget.id}",
                          "state":"${widget.state}"
                        };
                        debugPrint("element 1 state "+widget.state[0].toString());
                        allumerEteindre(jsonEncode(msg));
                       });
                    }, 
                      style: selected ?ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)):ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                      child: const Text("Tester")
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(onPressed: (){
                        if(_formKey.currentState!.validate()){
                          debugPrint("widget id "+widget.id.toString());
                          newDevice.idDev = widget.id.toString();
                          newDevice.state = widget.state;
                          deviceProvider.addDevice(newDevice);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DevicesUpdated()));
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
      ),
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