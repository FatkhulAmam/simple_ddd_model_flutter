
import 'dart:convert';

MainResponse mainResponseFromJson(String str) => MainResponse.fromJson(json.decode(str));

String mainResponseToJson(MainResponse data) => json.encode(data.toJson());

class MainResponse {
  MainResponse({
    required this.data,
  });

  Data data;

  factory MainResponse.fromJson(Map<String, dynamic> json) => MainResponse(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}
