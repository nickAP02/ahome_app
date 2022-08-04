// import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/planning_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
// import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:ago_ahome_app/model/planning.dart';
import 'package:provider/provider.dart';

class PlanningView extends StatefulWidget {
  const PlanningView({Key? key}) : super(key: key);

  @override
  State<PlanningView> createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
    bool isExpanded = false;
  bool _isOn = false;
  Color color = Colors.black87;
  // var getDate;
  String ?valSelectionne;
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
    TextEditingController _heureDebut = TextEditingController();
    TextEditingController _heureFin = TextEditingController();
    Planning planning = Planning(idPlan: "",nomPlan: "",dateDebut: "",dateFin: "",appareils: []);
    var roomProvider;
    var deviceProvider;
    var planningProvider;
  @override
  void initState() {
    roomProvider=Provider.of<RoomProvider>(context,listen:false);
    deviceProvider = Provider.of<DeviceProvider>(context,listen:false);
    planningProvider = Provider.of<PlanningProvider>(context,listen: false);
    super.initState();
  }
  // var datetime1 = DateTime(2000);
  // var datetime2 = DateTime(2030);

  
  @override
  Widget build(BuildContext context) {
    // List devices = []; 
    
    return Scaffold(
      backgroundColor: kBackground,
      
      appBar: AppBar(
        title: const Text("Ajout d'un planning"),
      ),
      body: FutureBuilder(
        future: deviceProvider.getDeviceData(),
        builder: (context,snapshot) {
          debugPrint("snapshot 1 "+snapshot.data.toString());
          if(snapshot.connectionState==ConnectionState.none){
            return Center(child: Text("Pas de données disponibles"));
          }
          // debugPrint("snapshot 2 "+snapshot.data.toString());
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator(color: kPrimaryColor,);
          }
          else{
            var value = snapshot.data as List<dynamic>;
            debugPrint("snapshot 3 "+value.toString());
            return Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
            child: Form(
            key: _formKey,
            child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  TextFormField(
                    controller: _titleController,
                    cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Ajouter un titre"
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        
                          debugPrint("title debug "+_titleController.text);
                          planning.nomPlan = _titleController.text;
                        if (value!.isEmpty) {
                          return 'Entrez une valeur';
                        }
                        else{
                          debugPrint("title debug "+_titleController.text);
                          value = _titleController.text;
                          debugPrint("title debug 2"+value);
                          planning.nomPlan = _titleController.text;
                        }
                        return planning.nomPlan;
                      },
                    ),
                    // Row(
                    //   children: [
                    //     Text("Heure d'allumage"),
                    //     Text(planning.dateDebut.toString())
                    // ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text("Heure d'extinction"),
                    //     Text(planning.dateFin.toString())
                    // ],
                    // ),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    DateTimePicker(
                      errorInvalidText: "Saisissez quelque chose",
                      timeFieldWidth: 50,
                      controller: _heureDebut,
                      cursorColor:kBackground,
                      // cursorColor: kPrimaryColor,
                      type: DateTimePickerType.time,
                      dateMask: 'd MMM, yyyy',
                      // initialValue: DateTime.now().toString(),
                      // firstDate: DateTime(2000),
                      // lastDate: DateTime(2100),
                      initialTime: TimeOfDay.now(),
                      icon: const Icon(Icons.event,color: kPrimaryColor,),
                      // dateLabelText: 'Date de début',
                      timeLabelText: "Heure d'allumage",
                      // timePickerEntryModeInput: true,
                      use24HourFormat: true,
                      onChanged: (val) =>{
                        
                        debugPrint("allumage"+_heureDebut.text),
                        planning.dateDebut = val.toString()
                      } ,
                      validator: (val) {
                         if (val!.isEmpty) {
                          return 'Entrez une valeur';
                        }
                        else{
                          val=_heureDebut.text;
                          debugPrint("heure debut"+val.toString());
                          planning.dateDebut = _heureDebut.text;
                          return planning.dateDebut;
                        }
                        
                      },
                      onSaved: (val){
                        debugPrint("heure dbu saved"+val.toString());
                        planning.dateDebut = _heureDebut.text;
                        },
                    ),
                    DateTimePicker(
                      timeFieldWidth: 50,
                      cursorColor:kBackground,
                      controller: _heureFin,
                      // cursorColor: kPrimaryColor,
                      type: DateTimePickerType.time,
                      dateMask: 'd MMM, yyyy',
                      // initialValue: DateTime.now().toString(),
                      // firstDate: DateTime(2000),
                      // lastDate: DateTime(2100),
                      initialTime: TimeOfDay.now(),
                      icon: const Icon(Icons.event,color: kPrimaryColor,),
                      // dateLabelText: 'Date de début',
                      timeLabelText: "Heure d'extinction",
                      // timePickerEntryModeInput: true,
                      use24HourFormat: true,
                      onChanged: (val) => {
                        debugPrint(val),
                        planning.dateFin = val.toString()
                        // debugPrint("heure fin"+_heureFin.text)
            
                        },
                      validator: (val) {
                         if (val!.isEmpty) {
                          return 'Entrez une valeur';
                        }
                        else{
                          debugPrint("heure fin"+val.toString());
                          val=_heureFin.text;
                          planning.dateFin = _heureFin.text;
                          return planning.dateFin;
                        }
                        
                      },
                      onSaved: (val){
                        debugPrint("heure fin"+val.toString());
                        planning.dateFin = _heureFin.text;
                      }
                    ),
                    // const Padding(padding: EdgeInsets.only(bottom: 20)),
                    deviceProvider.device.isEmpty?Center(child: Column(
                          children: [
                            CircularProgressIndicator(color: kPrimaryColor,),
                            Text("Patientez le chargement des données"),
                          ],
                        )):ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: deviceProvider.device.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:Text("${deviceProvider.device[index].room}"),
                          subtitle: Text("${deviceProvider.device[index].nameDev}"),
                          // leading:  Row(
                          //   children: [
                          //     Text("${roomProvider.room[index].appareils[index].conso}"),
                          //     Text("kwH"),
                          //   ],
                          // ),
                          trailing:  ElevatedButton
                            (
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(color),
                            ),
                            child: 
                            const Text
                            (
                              "Plannifier",
                              style: TextStyle(color: Colors.white)
                            ) ,
                            onPressed: () async{
                              
                                debugPrint("appuyé");
                                planning.appareils.insert(index,deviceProvider.device[index]);
                                debugPrint("appareils long "+planning.appareils.length.toString());

                             
                              // _sendAction();
                              // debugPrint("appuyé");
                            //  planning.appareils.addAll(roomProvider.room[index].appareils);
                              // debugPrint("appareils long "+planning.appareils.length.toString());
                            },     
                          ),
                        );
                      }), 
                    ElevatedButton
                    (
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                    ),
                    child: 
                    const Text
                    (
                      "Valider",
                      style: TextStyle(color: Colors.white)
                    ) ,
                    onPressed: () async{
                      debugPrint("current state "+_formKey.currentState!.validate().toString());
                      if(_formKey.currentState!.validate()){
                        var response;
                        if(response["statut"]==200){
                          planningProvider.addPlanning(planning);
                        }
                        else{
                           debugPrint("a problem here "+response["result"]);
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response["result"],style: TextStyle(color: Colors.red),)));
                        }
                      }
                      debugPrint("pff");
                      debugPrint("pff"+planning.nomPlan);
                      debugPrint("pff"+planning.dateDebut);
                      debugPrint("pff"+planning.dateFin);
                      debugPrint("pff"+planning.appareils.toString());

                      debugPrint("planning "+planning.toJson().toString());
                      //  planningProvider.addPlanning(planning);
                    //  else{
                    //     Text("Renseignez tous les champs avant de valider",style: TextStyle(color: Colors.red),);
                    //  }
                      // channel.sink.add();
                    },     
                  ),
                         
                ],
              ),
            ),
          );
          }
        }
      )
    );
  }
  void _sendAction(){
    //print(_isOn);
    if(_isOn ==false){
      setState(() {
        _isOn = true;  
        color = Colors.red;
      });
    }
    else{
      setState(() {
        _isOn = false;
        color = Colors.black87;
      });
    }
  }
  @override
  void dispose(){
    super.dispose();
  }
}