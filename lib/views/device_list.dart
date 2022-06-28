import 'dart:convert';
import 'dart:ui';

import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/views/device_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final client = http.Client();
  Future<List<Device>> getDevices() async{
    final response = await client.get(Uri.parse('http://10.20.1.1:5000/api/v1/devices'));
    print(response.toString());
    if(response.statusCode == 200){
      try {
        var data = jsonDecode(response.body);
        return data.map<Device>((json)=>Device.fromJson(json)).toList();
        
      } on Exception catch (e) {
        throw e.toString();
      }
    }
    else{
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }

class DeviceList extends StatefulWidget {
  const DeviceList();
 
  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  int index = 0;
  String name="";
  Color buttonColor = Colors.red;
  
  @override
  void initState() {
    getDevices();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //return a list of devicecard
    //ElevatedButton tester(on/off)
    //device add form
      return Container(
        height: 500,
        width: 400,
        child: FutureBuilder<List<Device>>(
          future: getDevices(),
          builder: (context,snapshot){
            print(snapshot.connectionState);
            if(snapshot.connectionState == ConnectionState.none || snapshot.hasData==false){
            return const Center(child: Text("Pas d'appareils disponibles"));
            }
            else if(snapshot.hasData == true && snapshot.connectionState== ConnectionState.done){
              name = snapshot.data!.map((e) => Text(e.nameDev)).toList().toString();
              
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  print(snapshot.data);
                  index = 0;
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeviceView("${snapshot.data![index].idDev}",snapshot.data![index].state)));
                    },
                    child: ListTile(
                      selectedColor: Colors.amber,
                      title: Text(name),
                      trailing: const Icon(Icons.arrow_right,color: Colors.amber,),
                      //tileColor: Colors.grey,
                    ),
                    
                  );
                  
                });
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.blue,));
            }
            return const Center(child: Text("Il n'y a rien qui se passe"));
          }
        ),
      );
  }

  // Widget afficheName(AsyncSnapshot<List<Device>> snapshot) {
  //   //bool value;
  //   int index = 0;
  //   print("arrive ici");
  //   //print(snapshot.data![index].name);
  //   //print(snapshot.data![index].id);
  //   print(snapshot.data);
  //   //print(snapshot.hasData);
  //   if(snapshot.hasData==false){
  //     return Text(
  //       "Device",
  //       style: const TextStyle(color: Colors.black),
  //     );
  //   }
  //   else{
  //      return Text(
  //       snapshot.data![index].id,style: const TextStyle(color: Colors.red),
  //       );
  //   }
   
  // }

  @override
  void dispose() {
    super.dispose();
  }
}