import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
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
  String ?valSelectionneCat;
  String ?valSelectionneP;
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
              Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                    hint: const Text("Icone"),
                    value: valSelectionneP,
                    items: List.generate(
                      iconesPieces.length, (index) => DropdownMenuItem<String>(
                        // alignment: Alignment.center,
                        value:iconesPieces[index]["piece"],
                        child: Image.asset(
                          iconesPieces[index]["piece"],
                          height: 30,
                          width: 30
                        )
                        )
                      ).toList(),
                      onChanged: (value){
                      setState(() {
                        debugPrint("value "+value.toString());
                        valSelectionneP = value;
                        var valIcone = valSelectionneP!.split('assets/images/icons/');
                        debugPrint("geng geng"+valIcone.toString());
                        room.icone =  valIcone[1];
                      });
                    }),
                ),
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
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            try{
                              dynamic request =await roomProvider.addRoom(room);
                              if(request["statut"]==200){
                                 setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(request["result"],style: TextStyle(color: Colors.white),)));
                                  Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(builder: (BuildContext build)=>Home()),
                                      ModalRoute.withName('/'),
                                      );
                                 
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