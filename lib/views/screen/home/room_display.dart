// import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';

class RoomDisplay extends StatelessWidget {
  final int selected;
  final Function callback;
  final dynamic room;
  const RoomDisplay( this.selected,  this.callback,  this.room);

  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        itemBuilder: (context, index)=>GestureDetector(
          onTap: ()=>callback(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selected==index?kPrimaryColor:  Colors.white,
            ),
            child:Text(
              '${room[index].nameRoom}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
        itemCount:room.length,
        separatorBuilder: (_,index)=>const SizedBox(width: 20)
      )
    );
  }
}