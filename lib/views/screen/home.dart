import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/theme_service.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:ago_ahome_app/views/device_list.dart';
import 'package:ago_ahome_app/views/device_view.dart';
import 'package:ago_ahome_app/views/planning_list.dart';
import 'package:ago_ahome_app/views/room_list.dart';
import 'package:ago_ahome_app/views/room_view.dart';
import 'package:ago_ahome_app/views/screen/planning_view.dart';
import 'package:ago_ahome_app/views/screen/stats.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text("Maison"),
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
      drawer:ClipRRect(
        borderRadius: const BorderRadius.only(bottomRight:Radius.elliptical(65, 65)),
        child: Drawer(
                backgroundColor: const Color.fromRGBO(20,115,209,1),
                elevation:300,
                width: 98,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading:IconButton(
                          icon:const Icon(Icons.dark_mode),
                          onPressed: (){
                            ThemeService().switchTheme();
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      leading: IconButton(
                        icon:const Icon(Icons.home,
                        size: 40,
                        color: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Home()));
                        },
                        
                      ),
                      // subtitle: const Text("Accueil",
                      // style: TextStyle(
                      //   color: Colors.white,
                      // ),),
                      
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Accueil",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // subtitle: const Text("Pièces", 
                        // style:TextStyle(color:Colors.white)
                        // ),
                        leading: IconButton(
                          icon:const Icon(
                            Icons.apartment,
                            color: Colors.white,
                            size: 40,
                            ),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Rooms()));
                          },)
                        ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Pièces",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      leading: IconButton(
                        icon:const Icon(Icons.device_hub,
                        color: Colors.white,
                        size: 40,),
                        onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>  DeviceList()));
                        }
                      )
                    ),
                    const SizedBox(height: 10,),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Appareils",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      leading: IconButton(
                        icon:const Icon(Icons.calendar_month,
                        color: Colors.white,
                        size: 40,),
                        onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Plannings()));
                        }
                      )
                    ),
                    const SizedBox(height: 10,),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Plannification",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      leading: IconButton(
                        icon:const Icon(Icons.bar_chart_sharp,
                        color: Colors.white,
                        size: 40,),
                        onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>  const Statistic()));
                        }
                      )
                    ),
                    const SizedBox(height: 10,),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Statistiques",
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                    ),
                    const SizedBox(height: 50,),
                    ListTile(
                      leading:IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: const Icon(Icons.logout,
                      color: Colors.white,
                      size: 40,
                      )
                      ) ,
                    )  
                  ],
                ),
              ),
      ),
      backgroundColor: kBackground,
      body: ListView(
        children: [
          Container(
            child: CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              arcType: ArcType.FULL,
              percent: 1,
              backgroundWidth: 100,
              startAngle: 45,
              rotateLinearGradient: true,
              arcBackgroundColor: Colors.indigo,
              //animation: true,
              //animationDuration: 1,
              curve: Curves.bounceInOut,
              restartAnimation: true,
              progressColor: kPrimaryColor,
              fillColor: kBackground,
              lineWidth: 30,
              radius: 120,
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
                            children: const[
                              Align(
                                alignment: Alignment.center,
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
                                fontSize: 20,
                                fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding:  EdgeInsets.only(top: 8)),
                        Padding(
                          padding:  const EdgeInsets.only(right: 35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Text(
                                    DateFormat('kk:mm').format(DateTime.now()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
          
          Padding(padding: const EdgeInsets.only(left: 15,top: 5),
            child: TabBar(
              indicatorPadding: const EdgeInsets.only(bottom: 10,top: 25),
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
              ),
              
            ],
          ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: TabBarView(
              dragStartBehavior: DragStartBehavior.start,
              controller: _tabController,
              children: [
               categoryDevice(),
               categoryDevice(),
               categoryDevice(),
              ]
            ),
          )
        ],
      ),
      floatingActionButton: 
      SpeedDial(
        visible: true,
        backgroundColor: kBackground,
        animatedIcon: AnimatedIcons.add_event,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            labelStyle: TextStyle(fontSize: 20),
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.devices,color: Colors.white,),
            label: "Ajouter un appareil",
            onTap: ()=>showDialog(context: context, builder: (BuildContext builder){
              return DeviceView("", "");
            })
          ),
          SpeedDialChild(
            labelStyle: TextStyle(fontSize: 20),
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.bed,color: Colors.white,),
            label: "Ajouter une pièce",
            onTap: ()=>showDialog(context: context, builder: (BuildContext builder){
             return RoomDevice();
            })
          ),
          SpeedDialChild(
            labelStyle: TextStyle(fontSize: 20),
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.event,color: Colors.white,),
            label: "Ajouter un planning",
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PlanningView()))
          )
        ],
        // child: const Icon(Icons.add,color: kPrimaryColor,),
        // backgroundColor: kBackground,
        // onPressed: (){
        //  showDialog(context: context,
        //   builder: (BuildContext context){
        //     return createRoom();
        //   }
        //   );
        // },
      ),
    );
  }
  Widget categoryDevice(){
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: ((panelIndex, isExpanded) {
          print(isExpanded);
          setState(() {
            isExpanded = !isExpanded;
          });
          print(isExpanded);
        }),
        children: categorieDevice.
        map((e) => ExpansionPanel(
          isExpanded: isExpanded,
          headerBuilder: (context,isExpanded)=>
          ListTile(
            title: Text(e['categorie']),
          ), 
          body:gridDiviceCard()
          )
        ).toList()
      ),
    );
  }

   Widget gridDiviceCard(){
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: 200,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  width: 100,
                  padding: const EdgeInsets.all(10),
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
                              colorOff: colorOn?const Color.fromRGBO(255, 255, 255, 0.5):tapColor,
                              iconOn: Icons.circle_outlined,
                              iconOff: Icons.circle_outlined,
                              colorOn: colorOn?tapColor:const Color.fromRGBO(255, 255, 255, 0.5),
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

/*Widget createDevice(){
  return DeviceView("","");
}



Widget createRoom(){
String? valSelectionne;
return 
      SimpleDialog(
        title: const Text("Enregistrement d'une pièce"),
        children:[
           Container(
            height: MediaQuery.of(context).size.height*0.4,
            constraints: const BoxConstraints(maxHeight: 500,minHeight: 250,maxWidth: 800,minWidth: 500),
             child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                        scrollPadding: const EdgeInsets.all(10),
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
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                      hint:  Text("Capteurs"),
                      
                      items: capteurs.map((e) => 
                      DropdownMenuItem<String>(
                        value:e,
                        child: Text(e))
                      ).toList(),
                      onChanged: (value){
                       setState(() {
                         valSelectionne = value;
                       });
                      },value: valSelectionne,
                   ),
                    ),
                  //const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:18.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //await RoomProvider.addRoom(room);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
                            }
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
                          child: const Text('Valider'),
                        ),
                      ),
                      
                      ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                      }, 
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                      child: const Text("Annuler")
                ),
                    ],
                  )
                ],
              ),
              ),
           ),
        ]
      );
  }*/

}