import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Calculator extends StatefulWidget {
  final String title;

  const Calculator({Key? key,required this.title}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int radioSelectionne = 0;
  int lowCal=0;
  int hiCal = 0;
  double poids=0.0;
  TextEditingController e= TextEditingController();
  bool genre = false;
  double age = 0.0;
  Map napActivite = {
    0 : "Faible", 
    1 : "Modéré" ,
    2 : "Forte"  
  };
  double taille = 170.0;
  Color setColor(){
  if(genre==true){
    return Colors.blue;
  }
  if(genre==false){
    return Colors.pink;
  }
  else{
    return Colors.amber;
  }
}
Widget platformSwitcher(){
  if(defaultTargetPlatform == TargetPlatform.iOS){
    return CupertinoSwitch(
    value:genre, 
    activeColor:  Colors.blue,
    onChanged:(bool b){
      setState(() {
        genre = b;
      
      });
    }
    );
  }
  else{
    return Switch(
      value:genre, 
      inactiveTrackColor:  Colors.pink,
      onChanged:(bool b){
        setState(() {
          genre = b;
        
        });
      }
    );
  }
}
void calcCalories(){
  if(age !=0 && poids != 0 && radioSelectionne != null){
    //calculer
    if(genre){
      lowCal = (66.4738 + (13.7516 * poids) + (5.0033 * taille) - (6.7558 * age)).toInt();
    }
    else{
      lowCal = (655.8955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)).toInt();
    }
    switch(radioSelectionne){
      case 0 :
        hiCal = (lowCal * 1.2).toInt();
        break;
      case 1 :
        hiCal = (lowCal * 1.2).toInt();
        break;
      case 2 :
      hiCal = (lowCal * 1.2).toInt();
      break;
      default :
      hiCal = lowCal;
      break;
    }
    setState(() {
      dialogue();
    });
  }
  else{
    //alerte tous les champs ne sont pas présents
    alerte();
  }
}
Widget body(){
  return  SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              texteAvecStyle("Remplissez tous les champs pour obtenir votre besoin journalier en calories"),
              padding(),
               Card(
                elevation: 10.0,
                child: Column(
                  children:<Widget> [
                      Row(
                       mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                       children : <Widget>[
                         padding(),
                          texteAvecStyle("Femme",color : Colors.pink),
                         platformSwitcher(),
                           texteAvecStyle("Homme",color : Colors.blue),
                       ]
                     ),
                    padding(),
                    ageButton(),
                    padding(),
                    texteAvecStyle("Vous mesurez : ${taille.toInt()} cm",color: setColor()),  
                   Slider(
                    value: taille,
                    activeColor: setColor(),
                    onChanged: (double d){
                      setState(() {
                        taille = d;
                      });
                    },
                    max: 215.0,
                    min:100.0
                    ),
                    padding(),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (dynamic str){
                      setState(() {
                        poids = double.tryParse(e.text)!.toDouble();
                      });
                    },
                    onSubmitted: (dynamic str){
                      setState(() {
                        poids = double.tryParse(e.text)!.toDouble();
                      });
                    },
                    
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Entrez votre poids en kilos. :"
                    ),
                    controller: e,
                    ),
                    Text("Votre poids est de : "+e.text.toString()+" kg"),
                    padding(),
                    texteAvecStyle("Niveau d'activté physique :",color: setColor()),
                    padding(),
                    rowRadio(),
                    padding()
                  ],
                ),
              ),
              padding(),
              calcButton()
            ],
          ),
        );
}
Future<Null> dialogue() async{
  return showDialog(
    context: context, 
    builder: (BuildContext buildContext){
      return SimpleDialog(
        title: texteAvecStyle("Votre besoin en calories",color: setColor()),
        contentPadding: const EdgeInsets.all(15.0),
        children:<Widget> [
          padding(),
          texteAvecStyle("Votre besoin de base est de : $lowCal kCal"),
          padding(),
          texteAvecStyle("Votre besoin énergétique est de : $hiCal kCal"),
          TextButton(
            onPressed: (){
              Navigator.pop(buildContext);
            }, 
            child: texteAvecStyle("OK",color: setColor()),
            
          )
        ],
      );
    }
    );
}
Future<Null> alerte() async{
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext buildcontext){
      return AlertDialog(
        title: texteAvecStyle("Erreur",color: setColor()),
        content: texteAvecStyle("Veuillez renseignez tous les champs", color: Colors.black87),
        actions:<Widget> [
          TextButton(
            onPressed: (){
              Navigator.pop(buildcontext);
            },
          child: texteAvecStyle("OK",color: Colors.red[400])
          ),
        ],
       );
    }
  );
}
Future<Null> montrerPicker() async{
  var choix = await  showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      );
      if(choix != null){
        var diff = DateTime.now().difference(choix);
        var jours = diff.inDays;
        var ans = (jours/365);
        setState(() {
          age = ans; 
        });
      }
}
Widget calcButton(){
  if(defaultTargetPlatform == TargetPlatform.iOS){
    return CupertinoButton(
      child: texteAvecStyle("Calculer",color: Colors.white), 
      onPressed:(){
        calcCalories();
      }
    );
  }else{
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary:  setColor()
      ), 
        child: texteAvecStyle("Calculer",color: Colors.white),
        onPressed: (){
          calcCalories();
        },
    );
  }
}
Widget ageButton(){
  if(defaultTargetPlatform == TargetPlatform.iOS){
    return CupertinoButton(
      child: texteAvecStyle(
        (age == 0)?"Appuyez pour entrer votre âge" : "Vous avez : ${age.toInt()} ans",
      color: Colors.white
      ),
     color: setColor(),
      onPressed: (()=>montrerPicker()),
    );
  }else{
    return  ElevatedButton(
      child: texteAvecStyle(
        (age == 0)?"Appuyez pour entrer votre âge" : "Vous avez : ${age.toInt()} ans",
      color: Colors.white
      ),style: ElevatedButton.styleFrom(
        primary:  setColor()
      ),
      onPressed: (()=>montrerPicker()),
    );
  }
}
Row rowRadio(){
  List<Widget> l = [];
  napActivite.forEach(
    (key,value) {
    Column colonne = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        Radio(
          activeColor: setColor(),
          value: key,
           groupValue: radioSelectionne,
            onChanged: (dynamic i){
              setState(() {
                 radioSelectionne =  i;
              });
            }), 
          texteAvecStyle(value, color: setColor())
      ],
    );
    l.add(colonne);
  }
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:l);
}
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: (()=>FocusScope.of(context).requestFocus(FocusNode())),
      child: (defaultTargetPlatform == TargetPlatform.iOS) ?
      CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: setColor(),
          middle: texteAvecStyle(widget.title),
        ),
        child: body()):
        Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor:  setColor(),
        ),
        body:body(),
      ),
    );
  }
} 

Padding padding(){
  return const Padding(padding: EdgeInsets.only(top: 20.0));
}

Text texteAvecStyle(String data, {color=Colors.black,fontSize=15.0}){
  return Text(
    data,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: fontSize
    ),
  );
}
