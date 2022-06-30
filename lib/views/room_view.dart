import 'package:ago_ahome_app/main.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomDevice extends StatefulWidget {
  const RoomDevice({Key? key}) : super(key: key);

  @override
  State<RoomDevice> createState() => _RoomDeviceState();
}

class _RoomDeviceState extends State<RoomDevice> {
  final  _formKey = GlobalKey<FormState>();
  late Room room;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return 
      SimpleDialog(
        title: const Text("Enregistrement d'une pièce"),
        children:[
           Container(
            height: 200,
             child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Nom de la catégorie"
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
              
                  ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //await RoomProvider.addRoom(room);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MyHomePage()));
                    }
                },
              child: const Text('Valider'),
              ),
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