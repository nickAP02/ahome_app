
class Role{
  int? id;
  String? roleName;
  Role({
      this.id,
      required this.roleName
     });

    factory Role.fromJson(Map<String,dynamic> json){
      return Role(
        id: json["id"]??"", 
        roleName: json["roleName"]??""
        );
    }
    Map<String, dynamic> toJson() => {
      'id': id,
      'roleName' : roleName
    };
}