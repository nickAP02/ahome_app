import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomDevice extends StatefulWidget {
  const RoomDevice({Key? key}) : super(key: key);

  @override
  State<RoomDevice> createState() => _RoomDeviceState();
}

class _RoomDeviceState extends State<RoomDevice> {
  final  _formKey = GlobalKey<FormState>();
  int index = 0;
  TextEditingController _nameController = TextEditingController();
  String? valSelectionne;
  Room room= Room(idRoom: "",nameRoom: "",appareils:[],capteurs:[]);

  @override
  void initState() {
    super.initState(); 
  }
  @override
  Widget build(BuildContext context) {
    var roomProvider = Provider.of<RoomProvider>(context,listen:false);
    return 
      SimpleDialog(
        title: const Text("Enregistrement d'une pièce"),
        contentPadding: const EdgeInsets.all(10),
        children:[
           Container(
            height: 200,
             child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    TextFormField(
                      cursorColor: kPrimaryColor,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Nom de la pièce"
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez le champ nom';
                      }
                      else{
                        value = _nameController.text;
                        room.nameRoom = value.toString();
                      }
                        return null;
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:18.0),
                        child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            try{
                              var request = roomProvider.addRoom(room);
                              if(request["statut"]==200){
                                 setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(request["result"],style: TextStyle(color: Colors.white),)));
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
                                });
                              }
                              
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(request["result"],style: TextStyle(color: Colors.red),)));
                              }
                            }catch(e){
                              throw e.toString();
                            }
                            
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur s'est produite, reprendre la saisie",style: TextStyle(color: Colors.red),)));
                          }
                        },
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
  }
  @override
  void dispose() {
    super.dispose();
  }
}