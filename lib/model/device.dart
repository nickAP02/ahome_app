class Device{
  String name = "";
  double conso =0.0;
  dynamic state = [];

  Device({required conso, required name, required state});

  factory Device.fromJson(Map<String, dynamic> json)=>Device(
    name : json['name'],
    conso : json['conso'],
    state : json['state']
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'conso': conso,
    'state' : state
  };
  
}