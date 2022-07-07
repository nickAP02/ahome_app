import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 final client = http.Client();
 Future<List<dynamic>> getRooms() async{
    final response = await client.get(Uri.parse('http://ahome.ago:5000/api/v1/rooms'));
    //print(response.statusCode);
    if(response.statusCode == 200){
      try{
        var data = jsonDecode(response.body).map((p)=>Room.fromJson(p)).toList();
         data as List<dynamic>;
         return data;
      }on NoSuchMethodError catch (_, n){
        throw n.toString();
      }
    }  
    
    else{
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
class NavBar extends StatelessWidget{
  NavBar({Key? key}) : super(key: key);
  var isLoaded = false;
  final int selected = 0;
  late final Function callback;
  //String room;
  //NavBar(this.selected,this.callback,this.room);
  @override
  Widget build(BuildContext context) {
    //final roomDevices =  rooms.devices.keys.toList();
    return FutureBuilder<List<dynamic>?>(
      future: getRooms(),
      builder:(context,snapshot){
          if(snapshot.connectionState == ConnectionState.none && snapshot.hasData==false){
            return const Center(child: Text("Pas de pièces disponibles"));
          }
          else if(snapshot.connectionState == ConnectionState.done && !snapshot.hasData){
            // room = snapshot.data![selected].nameRoom.toString();
            
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  itemCount:snapshot.data!.length,
                  itemBuilder: (context, index)=>GestureDetector(
                      onTap: ()=>callback(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selected==index?kPrimaryColor:Colors.white,
                        ),
                        child: Text(
                          snapshot.data![selected].nameRoom.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_,index)=>const SizedBox(width: 20)
                  ),
              );
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                heightFactor: 50,
                child: CircularProgressIndicator(color: Colors.blue,)
                );
            }
            return const Center(child: Text("Il n'y a rien qui se passe"));
          }
      );
  }
}