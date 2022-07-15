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
                if(snapshot.data == null){
                  debugPrint("snapshot "+snapshot.data.toString());
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                   return Center(child: Text('${snapshot.data}'));
                }
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: deviceProvider.device!.length,
                    itemBuilder: (context, index)=>
                      GestureDetector(
                        onTap: (){
                          setState(() {
                          selected = index;
                          });
                          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué cliqué sur cet appareil")));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeviceView(deviceProvider.device![index].idDev,deviceProvider.device![index].state)));
                        },
                        child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                          color: selected==index?kPrimaryColor:  Colors.white,
                        ),
                        child:deviceProvider.device![index].nameDev==""?Text(
                          'Appareil'+' '+'${index}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ):Text(
                          'Appareil'+' '+'${deviceProvider.device![index].nameDev}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        )
                        ),
                      )
                    //separatorBuilder: (_,index)=>SizedBox(width: 20)
                  );
              }
            ),
            FutureBuilder(
              future: capteurProvider.getCapteurData(),
              builder: (context,snapshot){
                if(snapshot.data == null){
                  debugPrint("snapshot "+snapshot.data.toString());
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                   return Center(child: Text('${snapshot.data}'));
                }
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: capteurProvider.capteur!.length,
                    itemBuilder: (context,index)=>GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = index;
                          });
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CapteurView(capteurProvider.capteur![index].id,capteurProvider.capteur![index].state)));
                        },
                        child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                          color: selected==index?kPrimaryColor:  Colors.white,
                        ),
                          child: capteurProvider.capteur![index].nameRoom==""?Text(
                            "Capteur"+' '+'${index}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ):Text(
                            "Capteur"+' '+'${capteurProvider.capteur![index].nameRoom}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ), 
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}