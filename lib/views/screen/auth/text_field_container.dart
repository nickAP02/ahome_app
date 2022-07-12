import 'package:ago_ahome_app/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key, required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        decoration:BoxDecoration(
          color: kPrimaryColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(29)
        ),
        child: child,
      ),
    );
  }
}