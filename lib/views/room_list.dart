import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Rooms extends StatelessWidget{
  Rooms();
  int index = 0;
  String name="";
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des pièces"),),
      body: ListView.builder(
        //padding: const EdgeInsets.only(top: 200),
        itemCount: 10,
        itemBuilder: (context, index)=>GestureDetector(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué cliqué sur cette pièce")));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.,
                color: selected==index?kPrimaryColor:  Colors.white,
              ),
              child:const Text(
                "Salon",
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