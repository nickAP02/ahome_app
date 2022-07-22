import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
    // var rooms = Provider.of<RoomProvider>(context,listen: false);
    return  Container(
    height: 80,
    width: 90,
    child: CircularPercentIndicator(
      circularStrokeCap: CircularStrokeCap.round,
      arcType: ArcType.FULL,
      percent: 1,
      backgroundWidth: 100,
      startAngle: 45,
      rotateLinearGradient: true,
      arcBackgroundColor: Colors.indigo,
      //animation: true,
      //animationDuration: 1,
      curve: Curves.bounceInOut,
      restartAnimation: true,
      progressColor: kPrimaryColor,
      fillColor: kBackground,
      lineWidth: 20,
      radius: 120,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Row(
              children: const[
                Text('29',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                ),
                Text("°C",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                //roomprovider value
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("20",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text("KWh",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
            Text(
              DateFormat('kk:mm').format(DateTime.now()),
              textAlign: TextAlign.center,
              style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
              ),
          ),
        ],
      ),
    ),
    );
  }
}