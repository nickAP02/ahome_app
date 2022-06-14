import 'dart:convert';

import 'package:ago_ahome_app/model/device.dart';
import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class DeviceCard extends StatefulWidget {
  const DeviceCard({Key? key}) : super(key: key);

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {

  final server = WebSocketChannel.connect(
  Uri.parse('ws://192.168.1.101:5000'),);
  bool _isSelected = false;
  bool switchVal = false;
  List <Device> devices = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
      //color: const Color.fromRGBO(20,115,209,1),
        margin: const EdgeInsets.fromLTRB(20,15, 20, 0),
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(
          color: _isSelected?const Color.fromRGBO(20,115,209,1):Colors.white,
          border: Border.all(
            width: 0.5,
            color: _isSelected?const Color.fromRGBO(20,115,209,1):Colors.white,
          ), 
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const Text("Interrupteur",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Switcher(
              value: false,
              colorOff: Colors.white,
              colorOn: const Color.fromRGBO(20,115,209,1),
              size: SwitcherSize.small,
              onChanged: (switchVal){
                setState(() {
                  switchVal = ! switchVal;
                  allumerEteindre();
                });
              }
              )
          ],
        ),
      ),
    );
    
  }
  void connect(){
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
    }
  @override
  void dispose(){
    super.dispose();
  }
}
