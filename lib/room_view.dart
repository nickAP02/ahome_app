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
  Room room = Room("","",0);
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
                hintText: "Nom de la pièce"
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez le champ nom';
              }
              else{
                room.name = value.toString();
              }
                return null;
              },
            ),
    
          ElevatedButton(
          onPressed: () {
            
            if (_formKey.currentState!.validate()) {
             
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enregistrement en cours')),
              );
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