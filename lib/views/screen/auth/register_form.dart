import 'package:ago_ahome_app/model/role.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/auth/login.dart';
import 'package:ago_ahome_app/views/screen/auth/text_field_container.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ago_ahome_app/model/user.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var usernameController = TextEditingController();
    var pwdController = TextEditingController();
    final  _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    User user = User(username: "",password: "",email: "",roles: Role(roleName: 'guest'));
    final userProvider = Provider.of<UserProvider>(context,listen: false);

    return  SingleChildScrollView(
      child: Form(
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
              controller: emailController,
              enableSuggestions: true,
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
                value = emailController.text;
                  debugPrint("email value"+value.toString());
                 bool _isValid = EmailValidator.validate(value);
                  debugPrint("emailvalidator "+_isValid.toString());
                  if (_isValid==false){
                    return 'Email invalide';
                  }
                  if(value.length<16){
                    return 'Email invalide';
                  }
                  else{
                    setState(() {
                     
                      user.email=value.toString();
                      debugPrint("email "+user.email.toString());
                    });
                  }
                return null;
              },
            )
          ),
            TextFieldContainer(
            child: TextFormField(
              controller: usernameController,
              enableSuggestions: true,
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
                value = usernameController.text;
                debugPrint("usernme value"+value.toString());
                if (value == null || value.isEmpty) {
                  return 'Entrez le nom d\'utilisateur';
                }
                if(value.length<8){
                  return 'Nom d\'utilisateur doit etre minimum 8 caracteres';
                }
                else{
                    setState(() {
                     
                    user.username = value.toString();
                     debugPrint("username "+user.username.toString());
                  });
                 
                }
                return null;
              },
             
            )
          ),
           TextFieldContainer(
            child: TextFormField(
              controller: pwdController,
              enableSuggestions: true,
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
                value = pwdController.text;
                debugPrint("pwd value "+value.toString());
                if (value == null || value.isEmpty) {
                  return 'Entrez le mot de passe';
                }
                if(value.length<8){
                  return 'Mot de passe doit etre minimum 8 caracteres';
                }
                else{
                  setState(() {
                   
                    user.password = value.toString();
                     debugPrint("pwd "+user.password.toString());
                  });
                 
                }
              },
            )
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: ()async{
                  debugPrint("current state 1"+_formKey.currentState!.validate().toString());
                  if(_formKey.currentState!.validate()){
                     debugPrint("current state 2"+_formKey.currentState!.validate().toString());
                    debugPrint("ici");
                    var req = await userProvider.register(user);
                    // debugPrint(req["statut"]);
                    if(req["statut"]==200){
                      debugPrint(user.roles!.roleName.toString());
                      setState(() {
                        user.roles!.roleName =="guest";
                        LocalStorage().setUser(user.email.toString());
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home()));
                      });
                      debugPrint(user.roles!.roleName.toString());
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verifiez les champs renseignes",style: TextStyle(color: Colors.red),)));
                    }
                    
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home()));
                  }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Une erreur s'est produite, reprendre la saisie",style: TextStyle(color: Colors.red),)));
                  }
                },
                child: const Text(
                  "INSCRIPTION",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kPrimaryColor
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Login()));
              },
              child: Text("Déjà inscrit ?Connectez-vous",style: TextStyle(color: kPrimaryColor),)
            ),
          )
        ],
      )
      ),
    );
  } 
}

