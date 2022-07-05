import 'package:flutter/material.dart';

class Plannings extends StatefulWidget {
  const Plannings({Key? key}) : super(key: key);

  @override
  State<Plannings> createState() => _PlanningsState();
}

class _PlanningsState extends State<Plannings> {
  var datetime1 = DateTime(2000);
  var datetime2 = DateTime(2030);
  var getDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Liste des plannings"),
      ),
      body: Container(
        height: 800,
        child: Column(
          children: [
            Container(
              height: 500,
              child: CalendarDatePicker(
                initialCalendarMode: DatePickerMode.day,
                initialDate: DateTime.now(), 
                firstDate:datetime1,
                lastDate:datetime2, 
                currentDate: getDate,
                onDateChanged: (value){
                  value = getDate;
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}