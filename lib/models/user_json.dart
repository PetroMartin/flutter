import 'dart:convert';

List<UserJson> userListJsonFromJson(String str) =>
    List<UserJson>.from(json.decode(str).map((x) => UserJson.fromJson(x)));

String userListJsonToJson(List<UserJson> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserJson userJsonFromJson(String str) => UserJson.fromJson(json.decode(str));

String userJsonToJson(UserJson data) => json.encode(data.toJson());

class UserJson {
  int? id;
  String username;
  String password;

  UserJson({
    this.id,
    required this.username,
    required this.password,
  });

  factory UserJson.fromJson(Map<String, dynamic> json) => UserJson(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
      };
}
