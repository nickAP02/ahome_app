import 'dart:convert';
import 'package:ago_ahome_app/model/device.dart';
import 'package:ago_ahome_app/utils/colors.dart';
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

  DeviceList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //return a list of devicecard
    //ElevatedButton tester(on/off)
    //device add form
    //final rooms  = roomDevices.device;
    return Scaffold(
      appBar: AppBar(title: Text("Liste des apareils"),),
      body: ListView.builder(
        //padding: const EdgeInsets.only(top: 200),
        itemCount: 10,
        itemBuilder: (context, index)=>GestureDetector(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué cliqué sur cet appareil")));
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeviceView("","")));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                color: selected==index?kPrimaryColor:  Colors.white,
              ),
              child:const Text(
                "Ampoule",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          scrollDirection: Axis.vertical,
          //separatorBuilder: (_,index)=>SizedBox(width: 20)
        ),
    );
  }
}