import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/device/device_list.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
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
  var datetime1 = DateTime(2000);
  var datetime2 = DateTime(2030);
  bool isExpanded = false;
  var getDate;
  late Planning _planning;
  String ?valSelectionne;
  
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var deviceProvider=Provider.of<DeviceProvider>(context,listen:false);
    return Scaffold(
      backgroundColor: kBackground,
      
      appBar: AppBar(
        title: Text("Ajout d'un planning"),
      ),
      body: Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
        child: Form(
        key: _formKey,
        child: Column(
            children: [
              Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Ajouter un titre"
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez une valeur';
                    }
                    else{
                      _planning.nomPlan = value.toString();
                    }
                    return null;
                  },
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                DateTimePicker(
                  cursorColor: kPrimaryColor,
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event,color: kPrimaryColor,),
                  dateLabelText: 'Date de début',
                  timeLabelText: "Heure de début",
                  selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  return true;
                  },
                    onChanged: (val) => print(val),
                    validator: (val) {
                    getDate = val;
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                DateTimePicker(
                 cursorColor: kPrimaryColor,
                 type: DateTimePickerType.dateTimeSeparate,
                 dateMask: 'd MMM, yyyy',
                 initialValue: DateTime.now().toString(),
                 firstDate: DateTime(2000),
                 lastDate: DateTime(2100),
                 icon: Icon(Icons.event,color: kPrimaryColor,),
                 dateLabelText: 'Date de fin',
                 timeLabelText: "Heure de fin",
                 selectableDayPredicate: (date) {
                 // Disable weekend days to select from the calendar
                 
                   return true;
                 },
                   onChanged: (val) => print(val),
                   validator: (val) {
                  //  print(val);
                   return null;
                 },
                 onSaved: (val) => print(val),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Container(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                    hint: const Text("Appareils"),
                    value: valSelectionne,
                    items: List.generate(deviceProvider.device!.length, (index) => DropdownMenuItem<String>(
                        value:deviceProvider.device![index].idDev,
                        child: Row(
                          children: [
                            Text(deviceProvider.device![index].idDev),
                          ],
                        ))
                      ).toList(),
                      onChanged: (value){
                      setState(() {
                        valSelectionne = value;
                        // _planning.appareils.addAll(valSelectionne);
                      });
                    }),
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
      )
    );
  }
}