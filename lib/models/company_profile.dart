// To parse this JSON data, do
//
//     final companyProfile = companyProfileFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobile_project/models/service_item_model.dart';
import 'package:mobile_project/utils/constants.dart';

CompanyProfile companyProfileFromJson(String str) => CompanyProfile.fromJson(json.decode(str));

//String companyProfileToJson(CompanyProfile data) => json.encode(data.toJson());

class CompanyProfile {
  int id;
  String companyName;
  String fav;
  String email;
  String contactPersonName;
  String companySize;
  String companyPhone;
  List<String> companyIndustry;
  String companyAddress;
  String lat;
  String long;
  File? image;
  DateTime createdAt;
  DateTime updatedAt;
  List<Service> services;
  String? password ;

  CompanyProfile({
    required this.id,
    required this.companyName,
    required this.fav,
    required this.email,
    required this.contactPersonName,
    required this.companySize,
    required this.companyPhone,
    required this.companyIndustry,
    required this.companyAddress,
    required this.lat,
    required this.long,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.services,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) => CompanyProfile(
    id: json["id"],
    companyName: json["company_name"],
    fav: json["fav"],
    email: json["email"],
    contactPersonName: json["contact_person_name"],
    companySize: json["company_size"],
    companyPhone: json["company_phone"],
    companyIndustry: json["company_industry"].split(','),
    companyAddress: json["company_address"],
    lat: json["lat"],
    long: json["long"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    image: json['image']!= null ?File("${STORAGE}${json['image']}") : null,
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "company_name": companyName,
  //   "fav": fav,
  //   "email": email,
  //   "contact_person_name": contactPersonName,
  //   "company_size": companySize,
  //   "company_phone": companyPhone,
  //   "company_industry": companyIndustry,
  //   "company_address": companyAddress,
  //   "lat": lat,
  //   "long": long,
  //   "image": image,
  //   "created_at": createdAt.toIso8601String(),
  //   "updated_at": updatedAt.toIso8601String(),
  //   "services": List<dynamic>.from(services.map((x) => x.toJson())),
  // };
}
