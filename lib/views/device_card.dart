import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
class DeviceCard extends StatefulWidget {
  final String name;
  final double conso;
  const DeviceCard({Key? key,required this.conso, required this.name}) : super(key: key);

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  late Future<List<Device>> devices;
  int index=0;
  bool _isSelected = false;
  bool switchVal = false;
  var tapColor = const Color.fromRGBO(20,115,209,1);
  var colorOn = false;
  var textColor = Colors.white;
  //String name ="";
  //double conso = 0.0;
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: devices,
      builder: (context,snapshot){
        if(snapshot.hasData){
            return Scaffold(
            body: GestureDetector(
              onTap: (){
                setState(() {
                  _isSelected = !_isSelected;
                  colorOn = true;
                });
              },
              onTapCancel: (){
                setState(() {
                  _isSelected = !_isSelected;
                  colorOn =  false;
                });
              },
              child: Container(
              //color: const Color.fromRGBO(20,115,209,1),
                margin: const EdgeInsets.fromLTRB(20,15, 20, 0),
                width: MediaQuery.of(context).size.width*0.5,
                height:200,
                decoration: BoxDecoration(
                  color: tapColor,
                  border: Border.all(
                    width: 0.5,
                    color: _isSelected?tapColor:Colors.white,
                  ), 
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: const [
                            Text("Interrupteur",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87
                            ),
                          ),
        
                          ]
                        ),
                        RotatedBox(
                          quarterTurns:90,
                          child: Switcher(
                            switcherButtonBoxShape: BoxShape.circle,
                            enabledSwitcherButtonRotate: true,
                            switcherButtonAngleTransform: 90,
                            value: false,
                            colorOff: Colors.white70,
                            iconOn: Icons.circle_rounded,
                            iconOff: Icons.circle_outlined,
                            colorOn: colorOn? tapColor : Colors.white,
                            size: SwitcherSize.small,
                            onChanged: (switchVal){
                              switchVal = !switchVal;
                              colorOn = !colorOn;
                            }
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.lightbulb_outline,
                        color: Colors.white,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.name),
                        const SizedBox(width: 50,height: 20,),
                        Text("${widget.conso}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "MontSerrat",
                        ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        else{
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        }
      }
      
    );
    
  }
  /*void connect(){
      StreamBuilder<dynamic>(
        stream: server.stream,
        builder: (context, snapshot) {
            return Text(
              snapshot.hasData?'${
                jsonDecode(snapshot.data)["State"]
              }'
                :
              'Pas de réponse du serveur'
              );
        }
      );
    }
    void allumerEteindre(){
      server.sink.add(devices);
    }*/
  @override
  void dispose(){
    super.dispose();
  }
}
