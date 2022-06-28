import 'package:ago_ahome_app/main.dart';
import 'package:ago_ahome_app/model/room.dart';
import 'package:flutter/material.dart';
import 'package:ago_ahome_app/services/http_service.dart';

class RoomDevice extends StatefulWidget {
  const RoomDevice({Key? key}) : super(key: key);

  @override
  State<RoomDevice> createState() => _RoomDeviceState();
}

class _RoomDeviceState extends State<RoomDevice> {
  final  _formKey = GlobalKey<FormState>();
  Room room = Room(1, "", "");
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enregistrement d'une pièce"),
      ),
      body: Form(
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
              //await HttpService.addRoom(room);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MyHomePage()));
            }
        },
        child: const Text('Valider'),
        ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {

    super.dispose();
  }
}