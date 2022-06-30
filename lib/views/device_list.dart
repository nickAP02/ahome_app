import 'dart:convert';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/device_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final client = http.Client();
  Future<List<Device>> getDevices() async{
    final response = await client.get(Uri.parse('http://ahome.ago:5000/api/v1/devices'));
    //print(response.toString());
    if(response.statusCode == 200){
      try {
        var data = jsonDecode(response.body);
        // print(data.toString());
        return data;
        
      } on Exception catch (e) {
        throw e.toString();
      }
    }
    else{
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }

class DeviceList extends StatelessWidget {
  int index = 0;
  String name="";
  int selected = 0;
  Color buttonColor = Colors.red;

  DeviceList();
  @override
  Widget build(BuildContext context) {
    //return a list of devicecard
    //ElevatedButton tester(on/off)
    //device add form
    //final rooms  = roomDevices.device;
    return Container(
        height: 100,
        //width: 400,
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: FutureBuilder<List<Device>>(
          future: getDevices(),
          builder: (context,snapshot){
            // print(snapshot.connectionState);
            // print(snapshot.hasData);
            if(snapshot.connectionState == ConnectionState.none || snapshot.hasData==false){
            return const Center(child: Text("Pas d'appareils disponibles"));
            }
            else if(snapshot.hasData == true && snapshot.connectionState== ConnectionState.done){
              name = snapshot.data![index].nameDev.toString();
              // print(name);
              
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index)=>GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeviceView("${snapshot.data![index].idDev}",snapshot.data![index].state)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selected==index?kPrimaryColor:  Colors.white,
                        ),
                        child:const Text(
                          "name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                    //separatorBuilder: (_,index)=>SizedBox(width: 20)
                  ),
              );
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.blue,));
            }
            return const Center(child: Text("Il n'y a rien qui se passe"));
          }
        ),
      );
  }
}