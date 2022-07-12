import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/auth/login.dart';
import 'package:ago_ahome_app/views/screen/auth/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    User user = User(idUser: "",username: "",password: "",email: "",plannings: {});
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    bool isValidEmail(String email){
      RegExp invalidEmail= RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
      return invalidEmail.hasMatch(email);
    }
    return  Form(
    key: _formKey,
    child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        const Text(
          "INSCRIPTION",
          style:TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold
            )
        ),
        SvgPicture.asset(
          "assets/images/signup.svg",
          height:size.height*0.35
        ),
          TextFieldContainer(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: kBackground
              ),
              hintText: "Email",
              icon:  Icon(
                Icons.email,
                color: kPrimaryColor,
              ),
              border: InputBorder.none
            ),
            validator: (value){
               if (value == null || value.isEmpty) {
                return 'Entrez l\'email';
              }
              else{
               isValidEmail(value)?null:"Email invalide reprendre la saisie";
              }
              return user.email=value.toString();
            },
          )
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
            try {
              userProvider.register(user);
              } on Exception catch (e) {
                debugPrint("Register ici");
               throw e.toString();
              }
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login()));
          },
          child: Container(
          height: 45,
          //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          decoration:BoxDecoration(
            color: kPrimaryColor.withOpacity(1),
            borderRadius: BorderRadius.circular(29)
          ),
          child: const Text(
            "INSCRIPTION",
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

