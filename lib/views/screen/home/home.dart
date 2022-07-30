import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/device/device_card.dart';
import 'package:ago_ahome_app/views/screen/home/conso_display_indicator.dart';
import 'package:ago_ahome_app/views/screen/home/custom_drawer.dart';
import 'package:ago_ahome_app/views/screen/home/custom_floating_action_button.dart';
import 'package:ago_ahome_app/views/screen/home/device_category_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  //late TabController _tabController;
  LocalStorage localStorage = LocalStorage();
  PageController? pageController;
  Function ?callback;
  int selected=0;
  bool _isSelected = false;
  bool isExpanded = false;
  var colorOn = false;
  int index=0;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  var textColor =  Colors.white;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RoomProvider>(context,listen: false).getRoomData().then((value){
      
      //pageController= PageController(length: Provider.of<RoomProvider>(context,listen: false).room!.length, vsync: this);
      });
    });

    Future.delayed(Duration.zero,(){
      TabController _tabController = TabController(length: Provider.of<RoomProvider>(context,listen: false).room!.length, vsync: this);
    //    var user = Provider.of<UserProvider>(context,listen: true).userRole;
    });
  
  }
  @override
  Widget build(BuildContext context) {
    // 
    var roomProvider= Provider.of<RoomProvider>(context,listen: false);
    var deviceProvider= Provider.of<DeviceProvider>(context,listen: false);
    var userProvider= Provider.of<UserProvider>(context,listen: true);
    PageController pageController = PageController();
    return WillPopScope(
      onWillPop: ()async{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Impossible de retourner en arrière")));
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
            if(snapshot.data == []){
              debugPrint(snapshot.data.toString());
              return const Text("Pièces non disponibles");
            }
            if(snapshot.data == null){
              debugPrint(snapshot.data.toString());
              return const Center(child: CircularProgressIndicator(color: kPrimaryColor, semanticsLabel: "Données non chargées",),);
            }
            if(snapshot.hasError){
               return const Center(child: Text('Une erreur s"est produite',style: TextStyle(color: Colors.red),));
            }
            // if(snapshot.connectionState==ConnectionState.waiting){
            //    return const Center(child: CircularProgressIndicator(color: kPrimaryColor,semanticsLabel: "En attente des données",));
            // }
            // if(snapshot.connectionState==ConnectionState.none){
            //    return const Center(child: Text("Nous n'avons pas pu connecter au serveur"));
            // }
            else{
              // debugPrint("data"+snapshot.data.toString());
              return SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                const ConsoDisplay(),
                //  const SizedBox(height: 110,),
                  // TabBar(tabs: tabs),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    // child: TabBar(
                    //   tabs: roomProvider.room.map((e)=>Tab(text:e.nameRoom)).toList(),
                    // ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      itemBuilder: (context, index)=>GestureDetector(
                        onTap: (){
                          setState(() {
                           
                            selected = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selected==index?kPrimaryColor:  Colors.white,
                          ),
                          child:Text(
                            roomProvider.room[index].nameRoom,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            // key: Key('$index'),
                          ),
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount:roomProvider.room.length,
                      separatorBuilder: (_,index)=>const SizedBox(width: 20)
                    )
                  ),
               Container(
                 height: MediaQuery.of(context).size.height,
                 width: 200,
                 child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: roomProvider.room.length,
                  itemBuilder: ((context, index) => Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: 200,
                    child: DeviceCard('${roomProvider.room[index].appareils[index].nameDev}',roomProvider.room[index].appareils[index].conso))
                    )
                  ),
               )
                // Text('${roomProvider.room[index].appareils}')
                  
                ],
              ),
            );
            }
            //  else{
             
            //   debugPrint(snapshot.data.toString());
            //   return const Text("Pièces non disponibles");
            //  } 
          }
        ),
        floatingActionButton: const CustomFloatingActionBtn(),
      ),
    );
  }
} 