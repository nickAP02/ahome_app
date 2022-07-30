import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des pièces")),
      body: Center(
        child: Consumer<RoomProvider>(
          builder: (context,value,child) {
            return value.loading?const CircularProgressIndicator(
              color: kPrimaryColor,
              semanticsLabel: "Chargement des données"
            ):
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                //padding: const EdgeInsets.only(top: 200),
                itemCount: value.room.length,
                itemBuilder: (context, index)=>GestureDetector(
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
                                    onPressed: () {
                                        setState(() {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez supprimé ${Provider.of<RoomProvider>(context).room[index].nameRoom}")));
                                          Navigator.of(context).pop();
                                        });
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
                  onDoubleTap: (){
                    setState(() {
                      selected = index;
                      showDialog(context: context, builder: (BuildContext build){
                        return SimpleDialog(
                            title: const Text("Voulez vous afficher cette pièce à l'accueil ?"),
                            contentPadding: const EdgeInsets.all(10),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:18.0),
                                    child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
                                    onPressed: () {
                                        setState(() {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
                                        });
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
                            ],
                          );
                        });
                    });
                  },
                  onTap: (){
                    setState(() {
                      selected = index;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué sur ${Provider.of<RoomProvider>(context).room[index].nameRoom}")));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.,
                      color: selected==index?kPrimaryColor:  Colors.white,
                    ),
                    child: Text( 
                      Provider.of<RoomProvider>(context).room[index].nameRoom,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                scrollDirection: Axis.vertical,
                  //separatorBuilder: (_,index)=>SizedBox(width: 20)
              ),
            );
          }
        ),
      ),
    );
  }
}