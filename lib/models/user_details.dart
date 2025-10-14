import 'dart:convert';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  final String uid;
  String? email;
  String? firstName;
  String? lastName;

  UserDetails({required this.uid, this.email, this.firstName, this.lastName});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    uid: json["uid"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
  };

  Map<String, dynamic> profileNameToJson() => {
    "firstName": firstName,
    "lastName": lastName,
  };

  UserDetails copyWith({
    String? uid,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
  }) {
    return UserDetails(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
