import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      NavigationBar(
        backgroundColor: const Color.fromRGBO(241,242,244, 1),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        elevation: 1.0,
        //animationDuration: const Duration(seconds: 5),
        destinations: const [
          NavigationDestination(
            icon:  Icon(Icons.minimize,color: Color.fromRGBO(20,115,209,1),),
            label: "Salon"
          ),
          NavigationDestination(
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
          ),
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