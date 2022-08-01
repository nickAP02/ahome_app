import 'package:ago_ahome_app/model/user.dart';
import 'package:ago_ahome_app/services/local_storage.dart';
import 'package:ago_ahome_app/services/providers/user_provider.dart';
import 'package:ago_ahome_app/utils/colors.dart';
import 'package:ago_ahome_app/views/screen/auth/register.dart';
import 'package:ago_ahome_app/views/screen/auth/text_field_container.dart';
import 'package:ago_ahome_app/views/screen/home/home.dart';
import 'package:ago_ahome_app/views/screen/space/space.dart';
import 'package:email_validator/email_validator.dart';
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
    String email = "";
    final bool _isValid = EmailValidator.validate(email);
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    return  WillPopScope(
       onWillPop: ()async{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Impossible de retourner en arrière")));
        return false;
      },
      child: SingleChildScrollView(
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
                  return null;
                },
              )
            ),
              Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  debugPrint("current state 1 "+_formKey.currentState!.validate().toString());
                  if(_formKey.currentState!.validate()){
                     debugPrint("current state 2 "+_formKey.currentState!.validate().toString());
                    debugPrint("ici");
                    userProvider.login(user);
                    debugPrint("provider ici "+userProvider.userLogin.toString());
                    if(userProvider.userLogin==null){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Une erreur s'est produite, reprendre la saisie",style: TextStyle(color: Colors.red),)));
                    }
                    else if(userProvider.userLogin["statut"]==200){
                      if(LocalStorage().getUser()==null){
                        LocalStorage().setToken(userProvider.userLogin["token"].toString());
                        LocalStorage().setUser(userProvider.userLogin["user"].toString());
                        setState(() {
                        // user.roles!.roleName =="guest";
                        // debugPrint("user"+LocalStorage().getUser());
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home()));
                      });
                      }
                      else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous êtes déjà connecté",style: TextStyle(color: Colors.red),)));
                      }
                      debugPrint(userProvider.userLogin["token"].toString());
                      
                      // debugPrint(user.roles!.roleName.toString());
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
                  "CONNEXION",
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Register()));
              },
              child: Text("Pas de compte ?Inscrivez-vous",style: TextStyle(color: kPrimaryColor),)
            ),
          )
          ],
        )),
      ),
    );
  }
}