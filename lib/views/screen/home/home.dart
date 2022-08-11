import 'dart:convert';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
// import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:ago_ahome_app/views/screen/home/conso_display_indicator.dart';
import 'package:ago_ahome_app/views/screen/home/custom_drawer.dart';
import 'package:ago_ahome_app/views/screen/home/custom_floating_action_button.dart';
// import 'package:ago_ahome_app/views/screen/home/device_category_display.dart';
import 'package:ago_ahome_app/views/screen/home/room_devices_display.dart';
import 'package:ago_ahome_app/views/screen/home/room_display.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  //late TabController _tabController;
  LocalStorage localStorage = LocalStorage();
  PageController? pageController;
  Function ?callback;
  int selected=0;
  bool _isSelected = false;
  bool switchVal = false;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  var colorOn = false;
  var textColor = Colors.white;
  final server = WebSocketChannel.connect(Uri.parse("ws://192.168.0.106:5000/api/v1/device/allumerEteindre/"));
  int index=0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var roomProvider= Provider.of<RoomProvider>(context,listen: false);
    var deviceProvider= Provider.of<DeviceProvider>(context,listen: false);
    var userProvider= Provider.of<UserProvider>(context,listen: true);
    PageController pageController = PageController();
    return WillPopScope(
      onWillPop: ()async{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pour quitter l'application veuillez vous déconnecter")));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Bienvenue",style: TextStyle(fontSize: 15),),
              Padding(
                padding:  EdgeInsets.only(right:18.0,left: 5),
                child: Text("",style: TextStyle(fontSize: 15,color: kPrimaryColor)),
              )
            ],
          ),
        ),
        drawer:const ClipRRect(
          borderRadius: BorderRadius.only(bottomRight:Radius.elliptical(65, 65)),
          child: Drawer(
            backgroundColor:Color.fromRGBO(20,115,209,1),
            elevation:300,
            width: 98,
            child: CustomDrawer(),
          ),
        ),
        backgroundColor: kBackground,
        body: FutureBuilder(
          future:roomProvider.getRoomData(),
          builder: (context,snapshot) {
            debugPrint("data "+snapshot.data.toString());
           
            
            if(snapshot.data == []){
              debugPrint("hold up "+snapshot.data.toString());
              return const Text("Pièces non disponibles");
            }
            if(snapshot.data == null){
              debugPrint("wait a min "+snapshot.data.toString());
              return const Center(child: CircularProgressIndicator(color: kPrimaryColor, semanticsLabel: "Données non chargées",),);
            }
            if(snapshot.hasError){
              debugPrint("error ok "+index.toString());
               return const Center(child: Text('Une erreur s"est produite',style: TextStyle(color: Colors.red),));
            }

            else{
              debugPrint("data else "+snapshot.data.toString());
              var value=snapshot.data as dynamic;
               var mapListRooms = snapshot.data as Map;
            var listRooms  = mapListRooms['result'] as List;
            var listRoomsNames = [];
            var listAppareilPerPiece = [];
            for(var i = 0;i<listRooms.length;i++){
              listRoomsNames.add(listRooms[i]['name']) ;
            //   for(var j = 0;j<listRoomsNames.length;j++){
            //   listAppareilPerPiece.add(listRooms[i]['appareils']) ;
              
            // }
            }
             debugPrint("somthing "+listRoomsNames.toString());
              debugPrint("data else "+snapshot.data.toString());
              return DefaultTabController(
                length: listRooms.length,
                child: 
                // SingleChildScrollView(
                //   child: 
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  const ConsoDisplay(),
                  TabBar(
                    tabs: [
                      for(var i=0;i<listRoomsNames.length;i++)...{
                        Tab(
                        child: Text(listRoomsNames[i],style:TextStyle(color: kPrimaryColor) ,),
                        // text: listRoomsNames[index],
                      )
                      }
                      
                    ]
                    ),
                  Container(
                    height: 300,
                    width:250,
                    child: TabBarView(
                      children: [
                        for(var i=0;i<listRoomsNames.length;i++)...{
                          //DeviceCard(mapListRooms["result"][i]["name"],mapListRooms["result"][i]["appareils"][1]["conso"], mapListRooms["result"][i]["appareils"][1]['state'], mapListRooms["result"][i]["appareils"][1]["id"]),
                          Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              // Text(mapListRooms["result"][i]["appareils"].toString()),
                              RoomDevicesDisplay(
                                // Provider.of<RoomProvider>(context,listen: true).getRoomIndex(), 
                                index,
                                (){
                                  debugPrint("index 2 "+index.toString());
                                  debugPrint("oo baby baby ");
                                  setState(() {
                                    // Provider.of<RoomProvider>(context,listen: false).setRoomIndex(index);
                                    index;
                                    debugPrint("pageview index "+index.toString());
                                  });
                                  debugPrint("push it real good ");
                                },
                                pageController,
                                mapListRooms["result"][i]
                        ),
                            ],
                          ),
                    )
                        }
                      ]
                    ),
                  ),
                  //  const SizedBox(height: 110,),
                    // RoomDisplay(selected, (int index){
                    //   debugPrint("do smth ");
                    //   setState(() {
                    //     selected=index;
                    //     Provider.of<RoomProvider>(context,listen: false).setRoomIndex(index);
                    //     debugPrint("index "+index.toString());
                    //   });
                    // pageController.jumpToPage(index);
                    // },
                    // value["result"]
                    // ), 
                    
                    // Container(
                    //   height: MediaQuery.of(context).size.height,
                    //   child: RoomDevicesDisplay(
                    //     Provider.of<RoomProvider>(context,listen: true).getRoomIndex(), 
                    //     (){
                    //       debugPrint("index 2 "+index.toString());
                    //       debugPrint("oo baby baby ");
                    //       setState(() {
                    //         Provider.of<RoomProvider>(context,listen: false).setRoomIndex(index);
                    //         debugPrint("pageview index "+index.toString());
                    //       });
                    //       debugPrint("push it real good ");
                    //     },
                    //     pageController,
                    //     value["result"]
                    //   ),
                    // )
                  ],
                ),
                         // ),
              );
            }
          }
        ),
        floatingActionButton: const CustomFloatingActionBtn(),
      ),
    );
  }
  void allumerEteindre(msg){
    debugPrint(msg);
    server.sink.add(msg);
  }
  Widget checkState(dynamic valeur, int index) {
    var value; 
    if(valeur[index].state[0]==1){
      debugPrint("jpp "+valeur[index]);
        value = deviceState(valeur[index].nameDev,valeur[index].idDev,valeur[index].state[0],index,valeur[index].conso);
      }
    else if(valeur[index].state[0]==0){
      value = deviceState(valeur[index].nameDev,valeur[index].idDev,valeur[index].state[0],index,valeur[index].conso);
    }
    return value;
  }
  Widget deviceState(String name,String id,int state,int index,double conso){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
        onTap: (){
          setState(() {
            colorOn = true;
            textColor = textColor;
            if(state==0){
              _isSelected = true;
              state=1;
              tapColor = tapColor;
              Map<String,dynamic> msg = {
                "id":id,
                "state":state
              };
              allumerEteindre(jsonEncode(msg));
            }
            else{
              _isSelected = false;
              state=0;
              tapColor = Colors.white;
               Map<String,dynamic> msg = {
                "id":id,
                "state":state
              };
              allumerEteindre(jsonEncode(msg));
            }
          });
        },
        child: Container(
          height:50,
          width: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isSelected?tapColor:Colors.amber,
            borderRadius: BorderRadius.circular(20)),
              //color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              // Icon(Icons.lightbulb_outline,color:_isSelected?textColor:Colors.black),
             Text(name, 
                style: TextStyle(
                  color:_isSelected?textColor:Colors.black,
                  fontWeight: FontWeight.bold
                )
              ),
              Text('${conso}'+' kwh', 
                style: TextStyle(
                  color:_isSelected?textColor:Colors.black,
                  fontWeight: FontWeight.bold
                )
              )
            ],
            )
          ),
        ),
      );
  }
} 