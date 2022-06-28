class Planning{
  DateTime dateDebut;
  DateTime dateFin;
    Planning(
      this.dateDebut,
      this.dateFin
    );
    Planning.fromJson(Map<String,dynamic> json):
      dateDebut = json["dateDebut"],
      dateFin = json["dateFin"];

    Map<String,dynamic> toJson()=>{
      'dateDebut':dateDebut,
      'dateFin':dateFin
    };
}