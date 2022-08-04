// import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
// import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  int index = 0;
  String name="";
  int selected = 0;
  String ?valSelectionneCat;
  String ?valSelectionneP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des utilisateurs")),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context,value,child) {
            var userProvider = Provider.of<UserProvider>(context);
            return value.loading?const CircularProgressIndicator(
              color: kPrimaryColor,
              semanticsLabel: "Chargement des données"
            ):
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                //padding: const EdgeInsets.only(top: 200),
                itemCount: value.users!.length,
                itemBuilder: (context, index)=>GestureDetector(
                  onLongPress: (){
                    setState(() {
                      selected = index;
                      showDialog(context: context, builder: (BuildContext buildContext){
                        return  AlertDialog(
                          title: const Text("Voulez vous supprimer ce utilisateur?",style: TextStyle(color: Colors.red),),
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
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez supprimé ${userProvider.users![index].email}")));
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
                  onTap: (){
                    setState(() {
                      selected = index;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous avez cliqué sur ${userProvider.users![index].email}")));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.,
                          color: selected==index?kPrimaryColor:  Colors.white,
                        ),
                        child: Text( 
                          '${userProvider.users![index].email}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                          hint: const Text("Roles"),
                          value: valSelectionneP,
                          items: List.generate(10, (index) => DropdownMenuItem<String>(
                              value:"",
                              child: Row(
                                children: const [
                                  Text(""),
                                ],
                              ))
                            ).toList(),
                            onChanged: (value){
                            setState(() {
                              valSelectionneP = value;
                              debugPrint(valSelectionneP);
                            });
                        }),
                      ),
                    ],
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