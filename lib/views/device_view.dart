import 'dart:convert';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';
class DeviceView extends StatefulWidget {
   String id;
   dynamic state;
   DeviceView(this.id,this.state, {Key? key}) : super(key: key);

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  static final client = http.Client();
  static addDevice(Device device) async{
    var response = await client.put(Uri.parse('http://ahome.ago:5000/api/v1/device/update/${device.idDev}/${device.nameDev}'), body: {
      "conso":device.conso.toDouble(),
    });
    //print(response);
    // print(response.body);
    if (response.statusCode == 200) {
     return jsonDecode(response.body);
    }
    
    else {
      Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
  final  _formKey = GlobalKey<FormState>();
  late Device newDevice;
  //final server = WebSocketChannel.connect(Uri.parse("ws://ahome.ago:5000/api/v1/device/allumerEteindre/"));
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String ?valSelectionne;
    int index =0;
    return SimpleDialog(
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
                  decoration: const InputDecoration(
                    hintText: "Puissance(en W)"
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez la puissance';
                    }
                    else{
                      newDevice.conso = double.tryParse(value)!;
                    }
                  return null;
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                      hint: const Text("Categorie"),
                      value: valSelectionne,
                      items: categorieDevice.
                      map((e) => 
                        DropdownMenuItem<String>(
                          value:e['categorie'],
                          child: Row(
                            children: [
                              Text(e['icone']),
                              Text(e['categorie']),
                            ],
                          ))
                        ).toList(),
                        onChanged: (value){
                        setState(() {
                          valSelectionne = value;
                          // print(value);
                          // print(valSelectionne);
                          // newDevice.categorie =  valSelectionne!;
                          // newDevice.dateConso =  DateTime.now();
                        });
                      }
                     ),
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    Map<String,dynamic> msg = {
                      "id":widget.id,
                      "state":widget.state
                      };
                    if (kDebugMode) {
                      print(msg);
                    }
                    // print(jsonEncode(msg));
                    //server.sink.add(jsonEncode(msg));
                  }, 
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                    child: const Text("Tester")
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        addDevice(newDevice);
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DeviceList()));
                      }
                      //server.sink.add(newDevice);
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
/*void connect(){
      StreamBuilder<dynamic>(
        stream: server.stream,
        builder: (context, snapshot) {
            return Text(
              snapshot.hasData?'${
                jsonDecode(snapshot.data)["State"]
              }'
                :
              'Pas de réponse du serveur'
              );
        }
      );
    }
*/
void allumerEteindre(){
  //final server = WebSocketChannel.connect(Uri.parse("ws://ahome.ago:5000/api/v1/device/allumerEteindre/"));
  //server.sink.add(id,state);
}  
  @override
  void dispose() {
    super.dispose();
  }
}