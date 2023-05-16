// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:mobile_project/models/service_item_model.dart';

List<ServiceResponse> serviceFromJson(String str) => List<ServiceResponse>.from(json.decode(str).map((x) => ServiceResponse.fromJson(x)));

String serviceToJson(List<ServiceResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceResponse {
  Company company;
  double distance;

  ServiceResponse({
    required this.company,
    required this.distance,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => ServiceResponse(
    company: Company.fromJson(json["company"]),
    distance: json["distance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "company": company.toJson(),
    "distance": distance,
  };
}

class Company {
  int id;
  String companyName;
  String fav;
  String email;
  String contactPersonName;
  String companySize;
  String companyPhone;
  String companyIndustry;
  String companyAddress;
  String lat;
  String long;
  File? image;
  DateTime createdAt;
  DateTime updatedAt;
  List<Service> services;

  Company({
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

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyName: json["company_name"],
    fav: json["fav"],
    email: json["email"],
    contactPersonName: json["contact_person_name"],
    companySize: json["company_size"],
    companyPhone: json["company_phone"],
    companyIndustry: json["company_industry"],
    companyAddress: json["company_address"],
    lat: json["lat"],
    long: json["long"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "fav": fav,
    "email": email,
    "contact_person_name": contactPersonName,
    "company_size": companySize,
    "company_phone": companyPhone,
    "company_industry": companyIndustry,
    "company_address": companyAddress,
    "lat": lat,
    "long": long,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

