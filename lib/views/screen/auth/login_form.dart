import 'package:ago_ahome_app/model/user.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/auth/text_field_container.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    User user = User(idUser: "",username: "",password: "",email: "",plannings: {});
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    return  Form(
    key: _formKey,
    child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        const Text(
          "CONNEXION",
          style:TextStyle(fontWeight: FontWeight.bold)
        ),
        SvgPicture.asset(
          "assets/images/login.svg",
          height:size.height*0.35
        ),
          TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.text,
            obscureText: false,
            decoration:const InputDecoration(
              hintStyle: TextStyle(
                color: kBackground
              ),
              hintText: "Nom d'utilisateur",
              icon: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              border: InputBorder.none
            ),
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'Entrez le nom d\'utilisateur';
              }
              else{
               user.username = value.toString();
              }
              return null;
            },
          )
        ),
         TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: kBackground
              ),
              hintText: "Mot de passe",
              icon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              suffixIcon:Icon(
                Icons.visibility,
                color: kPrimaryColor,
              ),
              border: InputBorder.none
            ),
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'Entrez le mot de passe';
              }
              else{
               user.password = value.toString();
              }
              return null;
            },
          )
        ),
        GestureDetector(
           onTap: () {
            userProvider.login(user);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
          },
          child: Container(
          height: 45,
          //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration:BoxDecoration(
            color: kPrimaryColor.withOpacity(1),
            borderRadius: BorderRadius.circular(29)
          ),
          child: const Text(
            "CONNEXION",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kBackground
            ),
          ),
              ),
        ),
      ],
    ));
  }
}