import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesUpdated extends StatefulWidget {
  dynamic updatedDevice;
 dynamic updatedCapteur;
  
  DevicesUpdated(this.updatedDevice,this.updatedCapteur);

  @override
  State<DevicesUpdated> createState() => _DevicesUpdatedState();
}

class _DevicesUpdatedState extends State<DevicesUpdated> {
  
  @override
  Widget build(BuildContext context) {
    var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des appareils"),),
      body:Text('Appareil')
    );
  }
}