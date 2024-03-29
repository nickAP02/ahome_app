import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:ago_ahome_app/views/screen/room/room_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  int index = 0;
  String name="";
  int selected = 0;
  var homeList = [];
  var deleteList = [];
  var roomProvider;
  var textColor = Colors.white;
  final  _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    roomProvider = Provider.of<RoomProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      roomProvider.getRoomData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des pièces")),
      body: Center(
        child: FutureBuilder(
          future:roomProvider.getRoomData(),
          builder: (context,snapshot) {
             debugPrint("value 1"+snapshot.data.toString());
            if(snapshot.data==null){
              return const Center(
                child: Text("Pas de pièces disponibles")
              );
            }
             debugPrint("value 2"+snapshot.data.toString());
            if(snapshot.data==[]){
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Pas de pièces disponibles")
                  ],
                )
              );
            }
            else{
              debugPrint("value "+snapshot.data.toString());
              var result = snapshot.data as Map;
              var value = result["result"] as List;
              var listePieces =                 List.generate(
                value.length, (index) =>
                GestureDetector(
                  onLongPress: (){
                    setState(() {
                      selected = index;
                      showDialog(context: context, builder: (BuildContext buildContext){
                        return  AlertDialog(
                          title: const Text("Voulez vous supprimer cette pièce ?",style: TextStyle(color: Colors.red),),
                            contentPadding: const EdgeInsets.all(10),
                            content:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:18.0),
                                    child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                    onPressed: () async{
                                      
                                      var request = await roomProvider.deleteRoom(value[index]["id"]);
                                      debugPrint("statut room view "+request["result"].toString());
                                      if(request["statut"]==200){
                                        setState(() {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez supprimé ${value[index]["name"]}")));
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },
                                    child: const Text('Oui'),
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, 
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                                  child: const Text("Non")
                                  ),
                                ],
                              )
                           );
                      });
                    });
                  },
                  onTap: (){
                    setState(() {
                      selected = index;
                    });
                    showDialog(context: context, builder: (BuildContext buildContext){
                    return  SimpleDialog(
                      title: const Text("Modification de la pièce"),
                      contentPadding: const EdgeInsets.all(10),
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.4,
                          constraints: const BoxConstraints(maxHeight: 500,minHeight: 250,maxWidth: 800,minWidth: 500),
                          child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                //width: 100,
                                child: TextFormField(
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    hintText: "Nom de la pièce"
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Entrez le champ nom';
                                  }
                                  else{
                                    
                                  }
                                    return null;
                                  },
                                ),
                              ),
                                Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ElevatedButton(onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        var val = value[index] as Room;
                                        var req = await roomProvider.updateRoom(val);
                                        if(req["statut"]==200){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Rooms()));
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(req["result"],style: TextStyle(color: Colors.red),)));
                                          // Text(req["result"]);
                                        }
                                        
                                      }
                                      // server.sink.add(newDevice);
                                    }, 
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
                                    child: const Text("Enregistrer")
                                ),
                              ),
                              ElevatedButton(onPressed: (){
                                Navigator.of(context).pop();
                                }, 
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                                child: const Text("Annuler")
                                )
                              ],
                            )
                          ],
                          ),
                        ),
                      )
                      ],
                    );
                                  
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                       Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder:(context)=>RoomDetail(value)
                      )
                      );
                      },
                      child: Container(
                        height: 255,
                        width: 150,
                        // padding: const EdgeInsets.all(20),
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //borderRadius: BorderRadius.,
                          boxShadow: [
                            BoxShadow(
                            color:kPrimaryColor.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)
                          )],
                          color: kPrimaryColor,
                        ),
                        
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration:BoxDecoration(
                                          shape: BoxShape.circle,
                                          // borderRadius: BorderRadius.circular(20),
                                          color: Colors.green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            roomProvider.nbOnDevices.isEmpty?Padding(
                                              padding: const EdgeInsets.only(left:50.0),
                                              child: Text("${Provider.of<RoomProvider>(context,listen:true).getNbOnDevices(value[index]["id"])}"),
                                            ):Padding(
                                              padding: const EdgeInsets.only(left:50.0),
                                              child: Text("0"),
                                            ),
                                            //  Text("allumés"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration:BoxDecoration(
                                          shape: BoxShape.circle,
                                      //borderRadius: BorderRadius.,
                                      color: Colors.red,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            roomProvider.nbOnDevices.isEmpty?Padding(
                                              padding: const EdgeInsets.only(left:50.0),
                                              child: Text("${Provider.of<RoomProvider>(context,listen:true).getOffDevices(value[index]["id"])}"),
                                            ):
                                            Padding(
                                              padding: const EdgeInsets.only(left:50.0),
                                              child: Text("0"),
                                            ),
                                            //  Text("éteints"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                   
                                ],
                              ),
                              Image.asset(
                                iconeAsset+value[index]["icone"],
                                color:textColor,
                                height: 100,
                              ),
                              Text( 
                                value[index]["name"],
                                style: const TextStyle(
                                   fontSize: 25,
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text("${Provider.of<RoomProvider>(context,listen:true).getRoomConso(value[index]["id"])}"+' MWh', 
                              style: TextStyle(
                                fontSize: 18,
                                color:textColor,
                                fontWeight: FontWeight.bold
                              )
                            )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
              return value.isEmpty?const CircularProgressIndicator(
              color: kPrimaryColor,
              semanticsLabel: "Chargement des données"
            ):
            Container(
              height: MediaQuery.of(context).size.height,
              // width: 300,
              child: GridView.count(
                crossAxisCount: 2,
                //padding: const EdgeInsets.only(top: 200),
                // itemCount: value.length,
                children:listePieces
            )
            );
            }
          }
        ),
      ),
    );
  }
}