import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/home/conso_display_indicator.dart';
import 'package:ago_ahome_app/views/screen/home/custom_drawer.dart';
import 'package:ago_ahome_app/views/screen/home/custom_floating_action_button.dart';
import 'package:ago_ahome_app/views/screen/home/device_category_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  //late TabController _tabController;
  PageController? pageController;
  Function ?callback;
  int selected=0;
  bool _isSelected = false;
  bool isExpanded = false;
  var colorOn = false;
  int index=0;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  var textColor =  Colors.white;
  final _formKey = GlobalKey<FormState>();
  Room room = Room(idRoom: "",nameRoom: "");
  var myroom;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RoomProvider>(context,listen: false).getRoomData().then((value){
     // _tabController = TabController(length: Provider.of<RoomProvider>(context,listen: false).room!.length, vsync: this);
      //pageController= PageController(length: Provider.of<RoomProvider>(context,listen: false).room!.length, vsync: this);
      });
    });
  
  }
  @override
  Widget build(BuildContext context) {
    var roomProvider= Provider.of<RoomProvider>(context,listen: false);
    var deviceProvider= Provider.of<DeviceProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text("Bienvenue"),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12,
            horizontal: 16),
            child: CircleAvatar(
              maxRadius: 15,
              backgroundImage: AssetImage("assets/lightning.png"),
            ),),
        ],
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
          if(snapshot.data == null){
            debugPrint(snapshot.data.toString());
            return const Center(child: Text("Rien a afficher"),);
          }
          if(snapshot.hasError){
             return Center(child: Text('${snapshot.data}'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ConsoDisplay(),
              SizedBox(height: 110,),
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Expanded(
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
                        child: Text(
                          roomProvider.room![index].nameRoom,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: roomProvider.room!.length,
                    separatorBuilder: (_,index)=>SizedBox(width: 20)
                  ),
                )
              ),
              CategoryDevice()
              // Container(
              //   height: 50,
              //   width: 100,
              //   child: ListView.separated(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     padding: EdgeInsets.zero,
              //     itemBuilder: (context, index) =>CategoryDevice(),
              //     separatorBuilder: (_,index)=>SizedBox(height: 50), 
              //     itemCount: 5
              //     ),
              // ),
              
            ],
          );
        }
      ),
      floatingActionButton: const CustomFloatingActionBtn(),
    );
  }
}