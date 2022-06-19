import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:ago_ahome_app/views/device_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ago_ahome_app/services/http_service.dart';
class NavBar extends StatefulWidget {

  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  final HttpService httpService = HttpService();

  List<Room>? rooms;
  var appareils;

  int currentPageIndex = 0;

  //late TabController _tabController =  TabController(length: rooms!.length, vsync: this);

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService.getRooms().then((value) {
      appareils = value!.toJson().values;
      print("value"+appareils);
    });

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: httpService.getRooms(),
      builder: (BuildContext context, AsyncSnapshot snapshot){ 

        if (snapshot.hasData) {
          return Container( 
            child: TabBar(
              controller: TabController(length: rooms!.length, vsync: this),
              tabs: [
                Tab(
                height:MediaQuery.of(context).size.height*0.2,
                text:snapshot.data.name
                ),]
            ),
            );
        }
        return Container(
          height:MediaQuery.of(context).size.height*0.8,
          child: TabBarView(
            controller:TabController(length: rooms!.length, vsync: this),
            children: [
          DeviceCard()
        ]),);

      }
    );
  }
}