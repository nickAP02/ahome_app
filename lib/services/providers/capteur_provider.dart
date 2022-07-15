import 'package:ago_ahome_app/model/capteur.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class CapteurProvider extends ChangeNotifier{
  List<Capteur>? capteur=[];
  double temperature=0;
  bool loading = false;
  final HttpService httpService = HttpService();
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