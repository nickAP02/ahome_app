import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);
  @override
  State<Rooms> createState() => _RoomsState();
}
class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const[
        Text("Liste des pieces")
      ],
    );
  }
}