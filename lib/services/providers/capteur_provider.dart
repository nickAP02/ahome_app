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
    notifyListeners();
    return noNamedCapteurs;
  }
  setNoNamedCapteurs(){
    debugPrint("liste vide capteur " +capteur.toString());
    if(capteur!=null){
      noNamedCapteurs = capteur!.where((element) => element.nameRoom.isEmpty).toList();
      notifyListeners();
    }
    else{
      debugPrint("liste vide capteurs " +noNamedCapteurs.toString());
    }
    notifyListeners();
  }
   List<Capteur>getNamedCapteurs(){
    // notifyListeners();
    return namedCapteurs;
  }
  setNamedCapteurs(){
    if(capteur!=null){
      namedCapteurs = capteur!.where((element) => element.nameRoom.isNotEmpty).toList();
      notifyListeners();
    }
    else{
      debugPrint("liste vide named capteurs " +namedCapteurs.toString());
    }
    
    notifyListeners();
  }
  Future getCapteurData() async{
    loading = true;
    capteur = await httpService.getCapteurs().then((value) => capteur=value);
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
  addCapteur(Capteur capteur) async{
    debugPrint("capteur");
    var result = httpService.addCapteur(capteur);
    debugPrint("result capteur add "+result.toString());
    notifyListeners();
  }
}