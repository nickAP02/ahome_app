import 'package:ago_ahome_app/services/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rooms extends StatelessWidget{
  Rooms();
  int index = 0;
  String name="";
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des pièces"),),
      body: Center(
        child: Consumer<RoomProvider>(
          builder: (context,value,child) {
            return value.loading?CircularProgressIndicator():
            ListView.builder(
              //padding: const EdgeInsets.only(top: 200),
              itemCount: value.room!.length,
              itemBuilder: (context, index)=>GestureDetector(
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué sur ${Provider.of<RoomProvider>(context).room![index].nameRoom}")));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.,
                      color: selected==index?kPrimaryColor:  Colors.white,
                    ),
                    child: Text( 
                      '${Provider.of<RoomProvider>(context).room![index].nameRoom}',
                      style: TextStyle(
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
      ),
    );
  }

}