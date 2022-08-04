import 'package:ago_ahome_app/services/providers/planning_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:switcher/core/switcher_size.dart';
// import 'package:switcher/switcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class Plannings extends StatefulWidget {
  const Plannings({Key? key}) : super(key: key);

  @override
  State<Plannings> createState() => _PlanningsState();
}

class _PlanningsState extends State<Plannings> {
  @override
  void initState() {
    var planningProvider = Provider.of<PlanningProvider>(context,listen:false);
    super.initState();
  }
  var planningProvider;
  int selected=0;
  var colorOn = false;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  // final channel = WebSocketChannel.connect(Uri.parse("ws://10.20.1.98:5000/api/v1/planning/on/"));
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Liste des plannings"),
      ),
      body: FutureBuilder(
        future: planningProvider.getPlannings(),
        builder: (context,snapshot) {
          if(snapshot.data==null){
              return Text("rien a afficher");
          }
          if(snapshot.data==[]){
            return CircularProgressIndicator();
          }
          else{
            var value = snapshot.data as List<dynamic>;
            debugPrint("snapshot "+value.toString());
            return Container(
            height: 800,
            child: ListView.builder(
                // padding: EdgeInsets.all(5),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: value.length,
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
                        title: Text(value[index].nomPlan),
                        subtitle: Row(
                          children: [
                              Text(value[index].dateDebut,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              const Text(" - ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              Text(value[index].dateFin,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        trailing: ElevatedButton
                          (
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                          ),
                          child: 
                          const Text
                          (
                            "Activer",
                            style: TextStyle(color: Colors.white)
                          ) ,
                          onPressed: () async{
                            // _sendAction();
                            // channel.sink.add(planningProvider.plannings[index].idPlan);
                            debugPrint("active");
                            // debugPrint("appareils long "+planning.appareils.length.toString());
                          },     
                        ),
                        // trailing:Switcher(
                        //   switcherButtonBoxShape: BoxShape.circle,
                        //   enabledSwitcherButtonRotate: true,
                        //   switcherButtonAngleTransform: 90,
                        //   value: false,
                        //   colorOff: colorOn?const Color.fromRGBO(255, 255, 255, 0.5):tapColor,
                        //   iconOn: Icons.circle_outlined,
                        //   iconOff: Icons.circle_outlined,
                        //   colorOn: colorOn?tapColor:const Color.fromRGBO(255, 255, 255, 0.5),
                        //   size: SwitcherSize.small,
                        //   onChanged: (switchVal){
                        //     debugPrint("appareil allumé, oh yeah");
                        //     switchVal = !colorOn;
                        //     colorOn = !colorOn;
                        //   }
                        // ),
                    )           //separatorBuilder: (_,index)=>SizedBox(width: 20)
                ),
              ),
           ),
      );
        }
          
        }
      )
    );
  }
  @override
  void dispose() {
    // channel.sink.close();
    super.dispose();
  }
}