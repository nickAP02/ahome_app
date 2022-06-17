import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ago_ahome_app/services/http_service.dart';
class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  // List<Room>? rooms;
  var isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      NavigationBar(
        backgroundColor: const Color.fromRGBO(241,242,244, 1),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        elevation: 1.0,
        //animationDuration: const Duration(seconds: 5),
        destinations: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) { 
              return const NavigationDestination(
                icon:  Icon(Icons.minimize,color: Color.fromRGBO(20,115,209,1),),
                label: "Salon"
              );
             },
          ),
          /*NavigationDestination(
            icon:  Icon(Icons.minimize,color: Color.fromRGBO(20,115,209,1),),
            label:"Cuisine"
          ),
          NavigationDestination(
            icon:  Icon(Icons.minimize,color: Color.fromRGBO(20,115,209,1),),
            label:"Chambre"
          ),
          NavigationDestination(
            icon:  Icon(Icons.minimize,color: Color.fromRGBO(20,115,209,1),),
            label: "Garage"
          ),*/
        ],
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },  
        selectedIndex: currentPageIndex,
      )
    );
  }
}