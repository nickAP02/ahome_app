import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/device/device_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({Key? key}) : super(key: key);

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
    //debugPrint("liste"+deviceProvider.device![index].nameDev);
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des apareils"),),
      body:FutureBuilder(
        future: deviceProvider.getDeviceData(),
        builder: (context,snapshot) {
          if(snapshot.data == null){
            debugPrint("snapshot "+snapshot.data.toString());
            return const Center(child: Text("Rien a afficher"),);
          }
          if(snapshot.hasError){
             return Center(child: Text('${snapshot.data}'));
          }
          return ListView.builder(
            itemCount: deviceProvider.device!.length,
            itemBuilder: (context, index)=>GestureDetector(
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
                  child:Text(
                    "Appareil "'${deviceProvider.device![index].idDev}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.vertical,
              //separatorBuilder: (_,index)=>SizedBox(width: 20)
            );
        }
      ),
    );
  }
}