import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ConsoDisplay extends StatelessWidget {
  const ConsoDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
    height: 100,
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
          // const Padding(padding:  EdgeInsets.only(top: 8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text(
                    DateFormat('kk:mm').format(DateTime.now()),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
              ),
            ],
          )
        ],
      ),
    ),
    );
  }
}