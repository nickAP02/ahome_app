import 'package:ago_ahome_app/services/providers/capteur_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/capteur/capteur_view.dart';
import 'package:ago_ahome_app/views/screen/device/device_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceList extends StatefulWidget {
  DeviceList();
  
  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  int index = 0;
  String name="";
  int selected = 0;
  Color buttonColor = Colors.red;
  var deviceProvider;
  var capteurProvider;
  @override
  void initState() {
    deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    super.initState();
  }
 
  
  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      appBar: AppBar(title: const Text("Appareils détectés"),),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Provider.of<DeviceProvider>(context,listen:true).getDeviceData(),
              builder: (context,snapshot) {
                Future.delayed(Duration.zero,(){
                  deviceProvider.setNoNamedDevice();
                  deviceProvider.setNamedDevice();
                });
                if(snapshot.data == null){
                  debugPrint("snapshot circular "+snapshot.data.toString());
                  return  Center(child: Column(
                    children: const[
                      CircularProgressIndicator(color: kPrimaryColor,),
                      Text("Chargement des données")
                    ],
                  ),);
                }
                if(snapshot.data == []){
                  debugPrint("snapshot "+snapshot.data.toString());
                  return const Text("Pas d'appareils détectés");
                }
                if(snapshot.hasError){
                   return Center(child: Text('${snapshot.hasError}'));
                }
                else{
                  return deviceProvider.noNamedDevices.isEmpty?Column(
                    children: [
                      Image.asset('assets/images/icons/peripherals.png',height: 200,width: 500,),
                      const Text("Pas de nouveaux appareils détectés"),
                    ],
                  ):ListView.builder(
                    padding: const EdgeInsets.all(5),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: deviceProvider.noNamedDevices.length,
                    itemBuilder: (context, index){
                      index = 0;
                     return GestureDetector(
                        onTap: (){
                          setState(() {
                          selected = index;
                          });
                          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué cliqué sur cet appareil")));
                          showDialog(
                            barrierDismissible: false,
                            context: context, 
                            builder: (BuildContext build){
                            return  DeviceView(deviceProvider.noNamedDevices[index].idDev,deviceProvider.noNamedDevices[index].state);
                          });
                        },
                        child: deviceTypeCheck(deviceProvider.noNamedDevices, index),
                    );
                    }
                    //separatorBuilder: (_,index)=>SizedBox(width: 20)
                  );
                }
                
                
              }
            ),
            FutureBuilder(
              future: capteurProvider.getCapteurData(),
              builder: (context,snapshot){
                Future.delayed(Duration.zero,(){
                  capteurProvider.setNamedCapteurs();
                  capteurProvider.setNoNamedCapteurs();
                });
                if(snapshot.data == null){
                  debugPrint("snapshot "+snapshot.data.toString());
                  return const Text("Pas de capteurs détectés");
                }
                if(snapshot.hasError){
                   return Center(child: Text('${snapshot.hasError}'));
                }
                else{
                   return capteurProvider.noNamedCapteurs.isEmpty?Column(
                     children: [
                      Image.asset('assets/images/icons/motion-sensor.png',height: 200,width: 500,),
                      const Text("Pas de nouveaux capteurs détectés"),
                     ],
                   ):ListView.builder(
                    padding:const EdgeInsets.all(5),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: capteurProvider.noNamedCapteurs.length,
                    itemBuilder: (context,index)=>GestureDetector(
                      onTap: (){
                        setState(() {
                          selected = index;
                        });
                        showDialog(
                          barrierDismissible: false,
                          context: context, 
                          builder: (BuildContext build){
                          return  CapteurView(capteurProvider.noNamedCapteurs[index].id,capteurProvider.noNamedCapteurs[index].state);
                        });
                      
                      },
                      child:deviceTypeCheck(capteurProvider.noNamedCapteurs, index)
                      ), 
                  );
                }
               
              },
            )
          ],
        ),
      ),
    );
  }

    Widget deviceTypeCheck(dynamic valeur, int index) {
      var value; 
    if(valeur[index].state[2]==1){
        value = deviceContainer("ampoule",index);
      }
    else if(valeur[index].state[2]==2){
      value = deviceContainer("prise",index);
    }
    else if(valeur[index].state[2]==3){
      value = deviceContainer("capteur",index);
    }
    return value;
  }
  Widget deviceContainer(String name, int index){
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
        color: selected==index?kPrimaryColor:  Colors.white,
      ),
      child:ListTile(
        title: const Text("Appareil"),
        subtitle: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
      )
    );
  }
}