import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/theme_service.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:ago_ahome_app/views/device_list.dart';
import 'package:ago_ahome_app/views/room_list.dart';
import 'package:ago_ahome_app/views/room_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isSelected = false;
  bool isExpanded = false;
  var colorOn = false;
  int index=0;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  var textColor =  Colors.white;
  final  _formKey = GlobalKey<FormState>();
  late Room room;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer:Drawer(
              backgroundColor: const Color.fromRGBO(20,115,209,1),
              elevation:300,
              width: 158,
              child: ListView(
                children: [
                  ListTile(
                    leading:IconButton(
                      icon:const Icon(Icons.dark_mode),
                      onPressed: (){
                        ThemeService().switchTheme();
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Accueil",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                    
                    leading: IconButton(
                      icon:const Icon(Icons.home,color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Home()));
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Pièces", 
                    style:TextStyle(color:Colors.white)
                    ),
                    leading: IconButton(
                      icon:const Icon(Icons.meeting_room_outlined,color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Rooms()));
                      },)
                    ),
                  ListTile(
                    title: const Text("Appareils",
                    style:TextStyle(color:Colors.white)
                    ),
                    leading: IconButton(
                      icon:const Icon(Icons.devices,color: Colors.white,),
                      onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>  DeviceList()));
                      }
                    )
                    ),
                  ListTile(
                    leading:IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.logout,color: Colors.white,)) ,
                  )  
                ],
              ),
            ),
      backgroundColor: kBackground,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(20,115,209,0.3),
                borderRadius: BorderRadius.circular(15)
              ),
              //color: Colors.blueGrey,
              child: CircularPercentIndicator(
                progressColor: Colors.black,
                backgroundColor: kPrimaryColor,
                fillColor: Colors.transparent,
                lineWidth: 20,
                radius: 90,
                center: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:10.0, left:50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top:20),
                                  child: Text("20",
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text("KWh",
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(padding:  EdgeInsets.only(top: 8)),
                          Padding(
                            padding:  EdgeInsets.only(right: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  Text("${
                                      DateFormat('kk:mm').format(DateTime.now())
                                    }",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                    ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          Padding(padding: EdgeInsets.only(left: 15,top: 5),
            child: TabBar(
              indicatorWeight: 25,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(40),
                color: kPrimaryColor
              ),
              dragStartBehavior: DragStartBehavior.start,
              controller: _tabController,
              tabs: const[
              Align(
                alignment: Alignment.center,
                child: Text("Cuisine",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ),),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Salon",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ),),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Chambre",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ),),
              )
            ],
          ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 15,right: 15),
            child: TabBarView(
              dragStartBehavior: DragStartBehavior.start,
              controller: _tabController,
              children: [
                gridDiviceCard(),
                gridDiviceCard(),
                gridDiviceCard(),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: kPrimaryColor,),
        backgroundColor: kBackground,
        onPressed: (){
         showDialog(context: context,
          builder: (BuildContext context){
            return createRoom();
          }
          );
        },
      ),
    );
  }
  Widget categoryDevice(){
    return SingleChildScrollView(
      child: ExpansionPanelList(
        children: categorieDevice.
        map((e) => ExpansionPanelRadio(
        value: e[index].toString(), 
        headerBuilder: (context,isExpanded)=>ListTile(title: e[index],), 
        body: ListTile(title: gridDiviceCard(),))
        ).toList()
      ),
    );
  }

   Widget gridDiviceCard(){
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 150),
      itemCount: 200,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
       itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
                setState(() {
                  _isSelected = !_isSelected;
                  colorOn = true;
                  textColor = textColor;
                });
              },
              onTapCancel: (){
                setState(() {
                  _isSelected = !_isSelected;
                  colorOn =  false;
                  textColor = Colors.black;
                });
              },
            child: Container(
                  height:50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isSelected?kPrimaryColor:Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                      //color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Switch",
                            style:TextStyle(
                                color:_isSelected?textColor:Colors.black)
                            ),
                            
                            RotatedBox(
                            quarterTurns:180,
                            child:Switcher(
                              switcherButtonBoxShape: BoxShape.circle,
                              enabledSwitcherButtonRotate: true,
                              switcherButtonAngleTransform: 90,
                              value: false,
                              colorOff: colorOn?Color.fromRGBO(255, 255, 255, 0.5):tapColor,
                              iconOn: Icons.circle_outlined,
                              iconOff: Icons.circle_outlined,
                              colorOn: colorOn?tapColor:Color.fromRGBO(255, 255, 255, 0.5),
                              size: SwitcherSize.small,
                              onChanged: (switchVal){
                                switchVal = !switchVal;
                                colorOn = !colorOn;
                              }
                            ),
                            ),
                          ],
                        ),
                        
                        Icon(Icons.lightbulb_outline,color:_isSelected?textColor:Colors.black),
                        
                        Text("Main light", 
                          style: TextStyle(
                            color:_isSelected?textColor:Colors.black,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        
                      ],
                    )
                    ),
          ),
        );
       }
       );
   }

Widget createRoom(){
return 
      SimpleDialog(
        title: const Text("Enregistrement d'une pièce"),
        children:[
           Container(
            height: 200,
             child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Nom de la catégorie"
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez le champ nom';
                      }
                      else{
                        room.nameRoom = value.toString();
                      }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Nom de la pièce"
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez le champ nom';
                      }
                      else{
                        room.nameRoom = value.toString();
                      }
                        return null;
                      },
                    ),
              
                  ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //await RoomProvider.addRoom(room);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
                    }
                },
              child: const Text('Valider'),
              ),
                  ],
              ),
            ),
          ),
        ]
      );
}

}