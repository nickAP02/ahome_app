import 'package:ago_ahome_app/model/role.dart';

class User{
  // late String idUser;
  // String firstName;
  // String lastName;
    String? username;
    String? password;
    String? email;
   Role? roles;
  // int phoneNumber;
  // late Map<String,List<Planning>> plannings;

  User({
    // this.firstName,
    // this.lastName,
    // required this.idUser,
    this.username,
    this.password,
    this.email,
    this.roles
    // required this.plannings
    // this.phoneNumber
  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      // idUser : json["idUser"] ?? "",
    // firstName = json["firstName"] as String,
    // lastName = json["lastName"] as String,
      username : json["username"]??"" ,
      password : json["password"]??"",
      email : json["email"] ??"",
      roles: Role.fromJson(json["role"])
      // phoneNumber = json["phoneNumber"] as int,
      // plannings : json["plannings"] ??""
    );
  }

  Map<String, dynamic> toJson() => {
    // 'firstName':firstName,
    // 'lastName':lastName,
    'username': username,
    'password' : password,
    'email' : email,
    // 'phoneNumber':phoneNumber,
    // 'plannings':plannings
  };

}