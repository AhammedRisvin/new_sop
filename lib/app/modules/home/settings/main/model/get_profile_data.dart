// To parse this JSON data, do
//
//     final getProfileData = getProfileDataFromJson(jsonString);

import 'dart:convert';

GetProfileData getProfileDataFromJson(String str) =>
    GetProfileData.fromJson(json.decode(str));

String getProfileDataToJson(GetProfileData data) => json.encode(data.toJson());

class GetProfileData {
  String? message;
  ProfileData? profileData;

  GetProfileData({
    this.message,
    this.profileData,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) => GetProfileData(
        message: json["message"],
        profileData: json["profileData"] == null
            ? null
            : ProfileData.fromJson(json["profileData"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "profileData": profileData?.toJson(),
      };
}

class ProfileData {
  String? userId;
  String? email;
  String? name;
  String? phoneNumber;
  String? dialCode;
  String? profileImage;
  Height? height;
  num? weight;
  DateTime? dateOfBirth;
  Location? location;
  String? gender;

  ProfileData({
    this.userId,
    this.email,
    this.name,
    this.phoneNumber,
    this.dialCode,
    this.profileImage,
    this.height,
    this.weight,
    this.dateOfBirth,
    this.location,
    this.gender,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        userId: json["userId"],
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        dialCode: json["dialCode"],
        profileImage: json["profileImage"],
        height: json["height"] == null ? null : Height.fromJson(json["height"]),
        weight: json["weight"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
        "dialCode": dialCode,
        "profileImage": profileImage,
        "height": height?.toJson(),
        "weight": weight,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "location": location?.toJson(),
      };
}

class Height {
  num? height;
  String? unit;

  Height({
    this.height,
    this.unit,
  });

  factory Height.fromJson(Map<String, dynamic> json) => Height(
        height: json["height"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "unit": unit,
      };
}

class Location {
  Location();

  factory Location.fromJson(Map<String, dynamic> json) => Location();

  Map<String, dynamic> toJson() => {};
}
