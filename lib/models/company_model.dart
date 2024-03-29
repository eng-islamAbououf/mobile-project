// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:mobile_project/models/service_response.dart';

CompanyModel companyFromJson(String str) => CompanyModel.fromJson(json.decode(str));

String companyToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  String email;
  String companySize;
  String companyAddress;
  String companyPhone;
  String? password;
  String contactPersonName;
  double long;
  double lat;
  List<String> companyIndustry;
  String companyName;

  CompanyModel({
    required this.email,
    required this.companySize,
    required this.companyAddress,
    required this.companyPhone,
    this.password='12345678',
    required this.contactPersonName,
    required this.long,
    required this.lat,
    required this.companyIndustry,
    required this.companyName,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    email: json["email"],
    companySize: json["company_size"],
    companyAddress: json["company_address"],
    companyPhone: json["company_phone"],
    contactPersonName: json["contact_person_name"],
    long: double.parse(json['long']),
    lat: double.parse(json['lat']),
    companyIndustry: (json['company_industry'] as String).split(',').map((e) => e.trim()).toList(),
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "company_size": companySize,
    "company_address": companyAddress,
    "company_phone": companyPhone,
    "password": password,
    "contact_person_name": contactPersonName,
    "long": '$long',
    "lat": '$lat',
    "company_industry": companyIndustry.join(','),
    "company_name": companyName,
  };
}

