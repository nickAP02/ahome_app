import 'package:ago_ahome_app/model/planning.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class PlanningProvider extends ChangeNotifier{

  List<Planning> plannings = [];
  final HttpService httpService = HttpService();

  Future addPlanning(Planning planning) async{
    debugPrint("add planning ");
    httpService.addPlanning(planning);
    notifyListeners();
  }

  Future getPlannings() async{
    plannings = await httpService.getPlannings();
    notifyListeners();
    return plannings;
  }

  Future updatePlanning(Planning planning) async{
    debugPrint("update planning ");
    httpService.updatePlanning(planning);
    notifyListeners();
  }

  Future deletePlanning(String id) async{
    debugPrint(" delete planning ");
    httpService.deletePlanning(id);
    notifyListeners();
  }


}