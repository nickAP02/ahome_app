import 'package:ago_ahome_app/services/providers/device_provider.dart';
import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:ago_ahome_app/model/planning.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class PlanningView extends StatefulWidget {
  const PlanningView({Key? key}) : super(key: key);

  @override
  State<PlanningView> createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  var datetime1 = DateTime(2000);
  var datetime2 = DateTime(2030);
  bool isExpanded = false;
  bool _isOn = false;
  Color color = Colors.black87;
  var getDate;
  late Planning _planning;
  String ?valSelectionne;
  final channel = WebSocketChannel.connect(Uri.parse("ws://127.0.0.1:5000/api/v1/device/allumerEteindre/"));
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var roomProvider=Provider.of<RoomProvider>(context,listen:true);
    TextEditingController _heureDebut = TextEditingController();
    TextEditingController _heureFin = TextEditingController();
    return Scaffold(
      backgroundColor: kBackground,
      
      appBar: AppBar(
        title: const Text("Ajout d'un planning"),
      ),
      body: Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
        child: Form(
        key: _formKey,
        child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                DateTimePicker(
                  // controller: _heureDebut,
                  cursorColor: kPrimaryColor,
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event,color: kPrimaryColor,),
                  // dateLabelText: 'Date de début',
                  timeLabelText: "Heure de début",
                  selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  return true;
                  },
                    onChanged: (val) => debugPrint(val),
                    validator: (val) {
                    getDate = val;
                    return null;
                  },
                  onSaved: (val) => debugPrint(val),
                ),
                DateTimePicker(
                // controller: _heureFin,
                 cursorColor: kPrimaryColor,
                 type: DateTimePickerType.dateTimeSeparate,
                 dateMask: 'd MMM, yyyy',
                 initialValue: DateTime.now().toString(),
                 initialTime: TimeOfDay.now(),
                 firstDate: DateTime(2000),
                 lastDate: DateTime(2100),
                 icon: const Icon(Icons.event,color: kPrimaryColor,),
                //  dateLabelText: 'Date de fin',
                 timeLabelText: "Heure de fin",
                 selectableDayPredicate: (date) {
                 // Disable weekend days to select from the calendar
                 
                   return true;
                 },
                  //  onChanged: (val) => debugPrint(val),
                   validator: (val) {
                    val = _heureDebut.text;
                    // _planning.dateDebut=val.toString();
                  //  print(val);
                   return null;
                 },
                 onSaved: (val) => debugPrint(val),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Container(
                  height: 200,
                  width: 500,
                  color: kPrimaryColor,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // Tab(child: Text('${roomProvider.room[index].nameRoom}')),
                          ListTile(
                            title:Text("appareil 1"),
                            subtitle: Text("0 kwH"),
                            // leading: Text('Allumé'),
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
                              onPressed: () {
                                _sendAction();
                              },     
                            ),
                          ),
                        ],
                      );
                    })
                  ),      
            ],
          ),
        ),
      )
    );
  }
  void _sendAction(){
    //print(_isOn);
    if(_isOn ==false){
      setState(() {
        color = Colors.red;
        _isOn = true;  
        // channel.sink.add(val);
      });
    }
    else{
      setState(() {
        color = Colors.black;
        _isOn = false;
        // channel.sink.add(val);
      });
    }
  }
  @override
  void dispose(){
    channel.sink.close();
    super.dispose();
  }
}