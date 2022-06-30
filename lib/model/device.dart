class Device{
  int idDev;
  String nameDev;
  double conso;
  dynamic state;
  DateTime dateConso =  DateTime.now();
  List<String> categorie = [
    'Eclairage',
    'Appareil informatique',
    'Chauffage et climatisation'
  ];

  Device.fromJson(Map<dynamic, dynamic> json):
    idDev = int.tryParse(json['id'])!,
    nameDev = json['name'],
    conso = double.tryParse(json['conso'])!,
    state = json['state'],
    dateConso = json['dateConso'];

  Map<dynamic, dynamic> toJson() => {
    'id':idDev,
    'name': nameDev,
    'conso': conso,
    'state' : state,
    'dateConso':dateConso
  };
  
}