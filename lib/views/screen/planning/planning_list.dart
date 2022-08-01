import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class Plannings extends StatefulWidget {
  const Plannings({Key? key}) : super(key: key);

  @override
  State<Plannings> createState() => _PlanningsState();
}

class _PlanningsState extends State<Plannings> {
  int selected=0;
  var colorOn = false;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Liste des plannings"),
      ),
      body: Container(
        height: 800,
        child: ListView.builder(
            // padding: EdgeInsets.all(5),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index)=>
              GestureDetector(
                onTap: (){
                    setState(() {
                      selected =  index;
                    });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                    color: selected==index?kPrimaryColor:  Colors.white,
                  ),
                  child:ListTile(
                    title: Text("Allumer les lampes de l'extérieur"),
                    subtitle: Row(
                      children: const[
                          Text("12h",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Text(" - ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Text("14h",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ],
                    ),
                    trailing:Switcher(
                      switcherButtonBoxShape: BoxShape.circle,
                      enabledSwitcherButtonRotate: true,
                      switcherButtonAngleTransform: 90,
                      value: false,
                      colorOff: colorOn?const Color.fromRGBO(255, 255, 255, 0.5):tapColor,
                      iconOn: Icons.circle_outlined,
                      iconOff: Icons.circle_outlined,
                      colorOn: colorOn?tapColor:const Color.fromRGBO(255, 255, 255, 0.5),
                      size: SwitcherSize.small,
                      onChanged: (switchVal){
                        debugPrint("appareil allumé, oh yeah");
                        switchVal = !colorOn;
                        colorOn = !colorOn;
                      }
                    ),
                )           //separatorBuilder: (_,index)=>SizedBox(width: 20)
            ),
          ),
       ),
    )
    );
  }
}