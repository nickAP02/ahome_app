import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/nav_bar.dart';
import 'package:ago_ahome_app/views/device_list.dart';
import 'package:ago_ahome_app/views/room_view.dart';
import 'package:flutter/material.dart';
import 'package:ago_ahome_app/services/room_provider.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  var selected = 0;
  final pageController = PageController();
  String room="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          NavBar(
          ),
          DeviceList()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          Provider.of<RoomProvider>(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RoomDevice()));
        },
        child: const Icon(Icons.add),
        ),
    );
  }
}