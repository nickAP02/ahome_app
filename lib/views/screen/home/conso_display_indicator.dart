import 'package:ago_ahome_app/services/providers/room_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
class ConsoDisplay extends StatefulWidget {
  const ConsoDisplay({Key? key}) : super(key: key);

  @override
  State<ConsoDisplay> createState() => _ConsoDisplayState();
}
class _ConsoDisplayState extends State<ConsoDisplay> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int index = 0;
    // var capteurProvider=Provider.of<CapteurProvider>(context,listen:false);
    var roomProvider = Provider.of<RoomProvider>(context,listen: false);
    return  CircularPercentIndicator(
      circularStrokeCap: CircularStrokeCap.round,
      arcType: ArcType.FULL,
      percent: 1,
      // backgroundWidth: ,
      startAngle: 45,
      rotateLinearGradient: true,
      arcBackgroundColor: Colors.indigo,
      //animation: true,
      //animationDuration: 1,
      curve: Curves.bounceInOut,
      restartAnimation: true,
      progressColor: kPrimaryColor,
      fillColor: kBackground,
      lineWidth: 15,
      radius: 100,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const[
            //     Text('29',
            //       style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold
            //       ),
            //     ),
            //     Text("°C",
            //       style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding:const EdgeInsets.only(top: 20,bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  //roomprovider value
                  roomProvider.room.isEmpty?const Text("0",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                    ),
                  ):Text("${roomProvider.getConsoGlobale()}",
                  //textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  const Text("KWh",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Text(
                DateFormat('kk:mm').format(DateTime.now()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
                ),
              ),
            ),
        ],
      ),
    );
  }
}