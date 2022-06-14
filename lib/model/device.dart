class Device{
  String name = "";
  double conso =0.0;
  dynamic state = [];

  Device(this.name, this.conso, this.state);

  Device.fromJson(Map<String, dynamic> json):
    name = json['name'] as String,
    conso = json['conso'] as double,
    state = json['state'] as List;


  Map<String, dynamic> toJson() => {
    'name': name,
    'conso': conso,
    'state' : state
  };
  
}