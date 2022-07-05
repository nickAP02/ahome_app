import 'package:ago_ahome_app/main.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:flutter/material.dart';

class RoomDevice extends StatefulWidget {
  const RoomDevice({Key? key}) : super(key: key);

  @override
  State<RoomDevice> createState() => _RoomDeviceState();
}

class _RoomDeviceState extends State<RoomDevice> {
  final  _formKey = GlobalKey<FormState>();
  int index = 0;
  String? valSelectionne;
  Room room= Room("","");

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return 
      SimpleDialog(
        title: const Text("Enregistrement d'une pièce"),
        contentPadding: const EdgeInsets.all(10),
        children:[
           Container(
            height: 200,
             child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Nom de la pièce"
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez le champ nom';
                      }
                      else{
                        room.nameRoom = value.toString();
                      }
                        return null;
                      },
                    ),
                    Row(children: [
                       DropdownButton<String>(
                          hint: const Text("Capteurs"),
                          value: valSelectionne,
                          items: capteurs.
                          map((e) => 
                            DropdownMenuItem<String>(
                              value: e['categorie'],
                              child: Row(
                                children: [
                                  Text(e['icone']),
                                  Text(e['categorie']),
                                ],
                              ))
                          ).toList(), 
                          onChanged: (value) {
                            setState(() {
                              valSelectionne =  value;
                              // print(value);
                              // print(valSelectionne);
                              room.capteur = valSelectionne!;
                            });
                            },
                        )
                    ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:18.0),
                        child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // await RoomProvider.addRoom(room);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MyHomePage()));
                          }
                        },
                        child: const Text('Valider'),
                        ),
                      ),
                       ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                          }, 
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                          child: const Text("Annuler")
                       ),
                    ],
                  )
                  ],
              ),
              ),
           ),
        ]
      );
  }
  @override
  void dispose() {

    super.dispose();
  }
}