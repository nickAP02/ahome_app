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
  
  @override
  Widget build(BuildContext context) {
    
    var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    var capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title: const Text("Appareils détectés"),),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: deviceProvider.getDeviceData(),
              builder: (context,snapshot) {
                Future.delayed(Duration.zero,(){
                  deviceProvider.setNoNamedDevice();
                  deviceProvider.setNamedDevice();
                });
                if(snapshot.data == null){
                  debugPrint("snapshot "+snapshot.data.toString());
                  return const Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
                }
                if(snapshot.hasError){
                   return Center(child: Text('${snapshot.hasError}'));
                }
                else{
                  return deviceProvider.namedDevices.isEmpty?Center(child: CircularProgressIndicator(color: kPrimaryColor,),):ListView.builder(
                    padding: EdgeInsets.all(5),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: Provider.of<DeviceProvider>(context,listen:true).getNoNamedDevices().length,
                    itemBuilder: (context, index)=>
                      GestureDetector(
                        onTap: (){
                          setState(() {
                          selected = index;
                          });
                          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué cliqué sur cet appareil")));
                          showDialog(context: context, builder: (BuildContext build){
                            return  DeviceView(Provider.of<DeviceProvider>(context,listen:true).getNoNamedDevices()[index].idDev,Provider.of<DeviceProvider>(context,listen:true).getNoNamedDevices()[index].state);
                          });
                        },
                        child: deviceTypeCheck(deviceProvider.noNamedDevices, index),
                      )
                    //separatorBuilder: (_,index)=>SizedBox(width: 20)
                  );
                }
                
                
              }
            ),
            FutureBuilder(
              future: capteurProvider.getCapteurData(),
              builder: (context,snapshot){
                if(snapshot.data == null){
                  debugPrint("snapshot "+snapshot.data.toString());
                  return const Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
                }
                if(snapshot.hasError){
                   return Center(child: Text('${snapshot.data}'));
                }
                else{
                   return capteurProvider.namedCapteurs.isEmpty?Center(child: CircularProgressIndicator(color: kPrimaryColor,),):ListView.builder(
                    padding: EdgeInsets.all(5),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: capteurProvider.noNamedCapteurs.length,
                    itemBuilder: (context,index)=>GestureDetector(
                      onTap: (){
                        setState(() {
                          selected = index;
                        });
                        showDialog(context: context, builder: (BuildContext build){
                          return  CapteurView(Provider.of<CapteurProvider>(context,listen:true).getNoNamedCapteurs()[index].id,Provider.of<CapteurProvider>(context,listen:true).getNoNamedCapteurs()[index].state);
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
        title: Text("Appareil"),
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