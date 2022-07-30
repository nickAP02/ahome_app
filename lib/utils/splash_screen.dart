import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/utils/constant.dart';
import 'package:ago_ahome_app/views/screen/auth/register.dart';
import 'package:ago_ahome_app/views/screen/space/space.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => __SplashScreenState();
}

class __SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _mockCheckForSession().then((status) =>{
      // if(status){
      //   _navigateToRegister()
      // }
      // else{
      //   _navigateToSpace()
      // }
      _navigateToSpace()
    } );
    
  }
  Future<bool>_mockCheckForSession() async{
    await Future.delayed(const Duration(milliseconds: 5000),(){});
    return true;
  }
  void _navigateToRegister(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context)=>const Register()
      )
    );
  }
  void _navigateToSpace(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context)=>const Space()
      )
    );
  } 
  @override
  Widget build(BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: kPrimaryColor,
        child: Image.asset(logo),
      );
  }
}