import 'package:ago_ahome_app/model/user.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/auth/text_field_container.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:ago_ahome_app/views/screen/space/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final  _formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var pwdController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    User user = User(username: "",password: "",email: "");
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    return  SingleChildScrollView(
      child: Form(
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
              controller: emailController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration:const InputDecoration(
                hintStyle: TextStyle(
                  color: kBackground
                ),
                hintText: "Email",
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                border: InputBorder.none
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Entrez l\'email';
                }
                else{
                  setState(() {
                     user.email=emailController.text;
                  });
                }
                return null;
              },
            )
          ),
           TextFieldContainer(
            child: TextFormField(
              controller: pwdController,
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
                 setState(() {
                   user.password = pwdController.text;
                 });
                }
                return null;
              },
            )
          ),
          GestureDetector(
             onTap: ()async {
              dynamic response  = await userProvider.login(user);
              debugPrint("reponse"+response.toString());
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Space()));
              // if(response["token"]!=null){
              //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
              // }
            //  else{
            //   debugPrint(response["result"]);
            //  }
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
      )),
    );
  }
}