import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class CapteurProvider extends ChangeNotifier{
  List<Capteur>? capteur=[];
  List<Capteur> noNamedCapteurs = [];
  List<Capteur> namedCapteurs = [];
  double temperature=0;
  bool loading = false;
  final HttpService httpService = HttpService();

  List<Capteur>getNoNamedCapteurs(){
    return noNamedCapteurs;
  }
  setNoNamedCapteurs(){
    noNamedCapteurs = capteur!.where((element) => element.nameRoom.isEmpty).toList();
    notifyListeners();
  }
   List<Capteur>getNamedCapteurs(){
    return namedCapteurs;
  }
  setNamedCapteurs(){
    namedCapteurs = capteur!.where((element) => element.nameRoom.isNotEmpty).toList();
    notifyListeners();
  }
  Future getCapteurData() async{
    loading = true;
    capteur = await httpService.getCapteurs();
    loading = false;
    notifyListeners();
    return capteur;
  }
  Future getTemperature(String temp) async{
   loading = true;
   temperature= await httpService.getTemperature(temp);
   notifyListeners();
   return temperature;
  }
  Future addCapteur(Capteur capteur) async{
    debugPrint("capteur");
    httpService.addCapteur(capteur);
    notifyListeners();
  }
}