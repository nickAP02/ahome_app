import 'package:flutter/material.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Text("Statistiques"),
      ),
    );
  }
}