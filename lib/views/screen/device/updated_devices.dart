import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/capteur/capteur_view.dart';
import 'package:ago_ahome_app/views/screen/device/delete_device.dart';
import 'package:ago_ahome_app/views/screen/device/device_view.dart';
import 'package:ago_ahome_app/views/screen/device/update_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
class DevicesUpdated extends StatefulWidget {
  DevicesUpdated();

  @override
  State<DevicesUpdated> createState() => _DevicesUpdatedState();
}

class _DevicesUpdatedState extends State<DevicesUpdated> {
  int selected = 0;
  int index =0;
  @override
  Widget build(BuildContext context) {
    var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    var capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des appareils"),),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: Provider.of<DeviceProvider>(context,listen:true).getNamedDevices().length,
              itemBuilder: (context, index)=>
                GestureDetector(
                  onLongPress: (){
                     setState(() {
                      selected = index;
                    });
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué sur cet appareil")));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeleteDevice(deviceProvider.device![index].idDev,deviceProvider.device![index].state)));
                  },
                  onTap: (){
                    setState(() {
                      selected = index;
                    });
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué sur cet appareil")));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateDevice(deviceProvider.device![index].idDev,deviceProvider.device![index].state)));
                  },
                  child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                    color: selected==index?kPrimaryColor:  Colors.white,
                  ),
                  child:Text(
                     '${Provider.of<DeviceProvider>(context,listen:true).namedDevices[index].nameDev}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  )
                  ),
                )
              //separatorBuilder: (_,index)=>SizedBox(width: 20)
            ),
           
            ListView.builder(
                padding: EdgeInsets.all(5),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: Provider.of<CapteurProvider>(context,listen:true).getNamedCapteurs().length,
                itemBuilder: (context,index)=>GestureDetector(
                  onTap: (){
                    setState(() {
                      selected = index;
                    });
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué sur ce capteur")));
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CapteurView(capteurProvider.capteur![index].id,capteurProvider.capteur![index].state)));
                  },
                  child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                    color: selected==index?kPrimaryColor:  Colors.white,
                  ),
                  child:Text(
                    'Capteur '+'${Provider.of<CapteurProvider>(context,listen:true).capteur![index].id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ), 
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        activeBackgroundColor: kPrimaryColor,
        backgroundColor: kBackground,
        child: IconButton(
        highlightColor: kPrimaryColor,
        icon: Icon(Icons.add),
        onPressed: (){
          showDialog(context: context, builder: (BuildContext build){
            return  DeviceView(Provider.of<DeviceProvider>(context,listen:true).getNamedDevices()[index].idDev,Provider.of<DeviceProvider>(context,listen:true).getNamedDevices()[index].state);
          });
        },
        ),
      )
    );
  }
}