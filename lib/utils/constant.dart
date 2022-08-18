 const url = "assets/images/";
const String logo = url + "logo.png";
const String iconeAsset="assets/images/icons/";
  List<Map<String,dynamic>> categorieDevice =[
    {
      'id':1,
      'categorie':'Eclairage',
      'icone':iconeAsset+"light-control.png"
    },
    {
      'id':2,
      'categorie':'Appareil informatique',
      'icone':iconeAsset+"peripherals.png"
    },
    {
      'id':3,
      'categorie':'Chauffage et climatisation',
      'icone':iconeAsset+"air-conditioner.png"
    },
    {
      'id':4,
      'categorie':'Electromenager',
      'icone':iconeAsset+"freezer.png"
    },
  ];
  List<Map> capteurs =[
    {
      'id':1,
      'categorie':'Présence',
      'icone':iconeAsset+"motion-sensor.png"
    },
    {
      'id':2,
      'categorie':'Température',
      'icone':iconeAsset+"thermostat.png"
    },
    // {
    //   'id':3,
    //   'categorie':'Température',
    //   'icone':'assets/images/icons/thermostat.png'
    // }
  ];
  List<Map> iconesPieces = [
    // {
    //   'id':1,
    //   'piece':iconeAsset+"living-room.png"
    // },
    {
      'id':2,
      'piece':iconeAsset+"kitchen.png"
    },
    {
      'id':3,
      'piece':iconeAsset+"bedroom.png"
    },
    {
      'id':4,
      'piece':iconeAsset+"bathtub.png"
    },
  ];
  List<Map> iconesAppareils = [
    {
      'id':1,
      'appareil':iconeAsset+"lightbulb.png"
    },
    {
      'id':2,
      'appareil':iconeAsset+"plug-power.png"
    }
  ];