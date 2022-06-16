class User{
  String id="";
  String username="";
  String email="";
  String password="";
  User(this.id,this.username,this.password, this.email);
  User.fromJson(Map<String,dynamic> json):
  id = json["id"] as String,
  username = json["username"] as String,
  password = json["password"] as String,
  email = json["email"] as String;
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password' : password,
    'email' : email
  };
}