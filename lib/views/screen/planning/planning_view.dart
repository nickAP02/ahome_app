// import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/planning_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/planning/planning_list.dart';
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
  int index = 0;
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
    List<bool> _listSelected = [];
    bool _isSelected=false;
  @override
  void initState() {
    roomProvider=Provider.of<RoomProvider>(context,listen:false);
    deviceProvider = Provider.of<DeviceProvider>(context,listen:false);
    planningProvider = Provider.of<PlanningProvider>(context,listen: false);
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: kBackground,
      
      appBar: AppBar(
        title: const Text("Ajout d'un planning"),
      ),
      body: 
      FutureBuilder(
        future:  deviceProvider.getNamedDevices(),
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
            // var value = snapshot.data as List;
            debugPrint("snapshot 3 "+snapshot.data.toString());
            return 
            Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
            child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    // const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                          return null;
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
                        // onChanged: (val) =>{
                          
                        //   debugPrint("allumage"+_heureDebut.text),
                        //   planning.dateDebut = val.toString()
                        // } ,
                        validator: (val) {
                           if (val!.isEmpty) {
                            return 'Entrez une valeur';
                          }
                          else{
                            val=_heureDebut.text;
                            debugPrint("heure debut"+val.toString());
                            planning.dateDebut = _heureDebut.text;
                            return null;
                          }
                          
                        },
                        // onSaved: (val){
                        //   debugPrint("heure dbu saved"+val.toString());
                        //   planning.dateDebut = _heureDebut.text;
                        //   },
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
                        // onChanged: (val) => {
                        //   debugPrint(val),
                        //   planning.dateFin = val.toString()
                        //   // debugPrint("heure fin"+_heureFin.text)
              
                        //   },
                        validator: (val) {
                           if (val!.isEmpty) {
                            return 'Entrez une valeur';
                          }
                          else{
                            debugPrint("heure fin"+val.toString());
                            val=_heureFin.text;
                            planning.dateFin = _heureFin.text;
                            return null;
                          }
                          
                        },
                        // onSaved: (val){
                        //   debugPrint("heure fin"+val.toString());
                        //   planning.dateFin = _heureFin.text;
                        // }
                      ),
                      // const Padding(padding: EdgeInsets.only(bottom: 20)),
                      // roomProvider.roomDevices.isEmpty
                      Provider.of<DeviceProvider>(context,listen:true).namedDevices.isEmpty?Center(child: Column(
                            children: const[
                              CircularProgressIndicator(color: kPrimaryColor,),
                              Text("Patientez le chargement des données"),
                            ],
                          )):ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:   deviceProvider./*namedDevices*/device.length,
                        itemBuilder: (context, index) {
                          _listSelected.add(false);
                          return CheckboxListTile(
                          //  value: false,
                          
                            selected: _listSelected[index],
                            value: _listSelected[index],
                            onChanged: (value){
                              debugPrint("index "+index.toString());
                             setState(() {
                               _listSelected[index] = ! _listSelected[index];
                               planning.appareils.insert(index,  deviceProvider./*namedDevices*/device[index]);
                            //  debugPrint("value "+ deviceProvider./*namedDevices*/device.toString());
                            //    _isSelected = value!;
                             });
                              
                              debugPrint("appareils long "+planning.appareils.length.toString());
                            },
                            // selected: _isSelected[index],
            
                            // activeColor: kPrimaryColor,
                            checkColor: kBackground,
                            title:Text("${Provider.of<DeviceProvider>(context,listen:true).namedDevices[index].room}"),
                            subtitle: Text("${Provider.of<DeviceProvider>(context,listen:true).namedDevices[index].nameDev}"),
                            // leading:  Row(
                            //   children: [
                            //     Text("${roomProvider.room[index].appareils[index].conso}"),
                            //     Text("kwH"),
                            //   ],
                            // ),
                            // secondary:  ElevatedButton
                            //   (
                            //   style: ButtonStyle(
                            //     backgroundColor: MaterialStateProperty.all<Color>(color),
                            //   ),
                            //   child: 
                            //   const Text
                            //   (
                            //     "Plannifier",
                            //     style: TextStyle(color: Colors.white)
                            //   ) ,
                            //   onPressed: () async{
                                
                            //       debugPrint("appuyé");
                                  
              
                               
                            //     // _sendAction();
                            //     // debugPrint("appuyé");
                            //   //  planning.appareils.addAll(roomProvider.room[index].appareils);
                            //     // debugPrint("appareils long "+planning.appareils.length.toString());
                            //   },     
                            // ),
                          );
                        }), 
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:70.0,right: 40),
                            child: ElevatedButton
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
                                var response=planningProvider.addPlanning(planning);
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Planning enregistré",style: TextStyle(color: Colors.white))));
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(builder: (BuildContext build)=>Plannings()),
                                      ModalRoute.withName('/'),
                                      );
                              
                              }
                              
                            },     
                      ),
                          ),
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).pop();
                        }, 
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white12)),
                        child: const Text("Annuler")
                      )
                    ],
                    ),
                           
                  ],
                ),
            ),
            ),
          // )
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
