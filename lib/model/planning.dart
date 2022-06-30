class Planning{
  int idPlan;
  DateTime dateDebut;
  DateTime dateFin;
  Map<String,dynamic> user;
    Planning.fromJson(Map<String,dynamic> json):
      idPlan = json["idPlan"],
      dateDebut = json["dateDebut"],
      dateFin = json["dateFin"],
      user =  json["user"];

    Map<String,dynamic> toJson()=>{
      'idPlan':idPlan,
      'dateDebut':dateDebut,
      'dateFin':dateFin,
      'user' : user
    };
}