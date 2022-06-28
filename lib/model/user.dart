import 'package:ago_ahome_app/model/planning.dart';

class User{
  String idUser;
  String firstName;
  String lastName;
  String username;
  String password;
  String email;
  int phoneNumber;
  Map<String,List<Planning>> plannings;

  User(
    this.idUser,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.plannings
    );

  User.fromJson(Map<String,dynamic> json):
    idUser = json["idUser"] as String,
    firstName = json["firstName"] as String,
    lastName = json["lastName"] as String,
    username = json["username"] as String,
    password = json["password"] as String,
    email = json["email"] as String,
    phoneNumber = json["phoneNumber"] as int,
    plannings = json["plannings"] as dynamic;

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'firstName':firstName,
    'lastName':lastName,
    'username': username,
    'password' : password,
    'email' : email,
    'phoneNumber':phoneNumber,
    'plannings':plannings
  };

}