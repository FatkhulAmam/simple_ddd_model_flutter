
import 'dart:convert';

MainResponse mainResponseFromJson(String str) => MainResponse.fromJson(json.decode(str));

String mainResponseToJson(MainResponse data) => json.encode(data.toJson());

class MainResponse {
  MainResponse({
    required this.id,
    required this.name,
    required this.email,
  });

  int id;
  String name;
  String email;

  factory MainResponse.fromJson(Map<String, dynamic> json) => MainResponse(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
  };
}
