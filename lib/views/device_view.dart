import 'package:ago_ahome_app/main.dart';
import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  final  _formKey = GlobalKey<FormState>();
  Device newDevice =  Device("",0,"");
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enregistrement d'un appareil"),
      ),
      body: Form(
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
                  newDevice.name = value.toString();
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
                    newDevice.conso = value as double;
                  }
                 return null;
                },
              ),
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