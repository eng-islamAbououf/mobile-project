import 'dart:convert';

import 'package:mobile_project/models/company_model.dart';
import 'package:mobile_project/models/service_response.dart';

CompanyModelResponse companyResponseFromJson(String str) => CompanyModelResponse.fromJson(json.decode(str));

String companyResponseToJson(CompanyModelResponse data) => json.encode(data.toJson());

class CompanyModelResponse{

  Company company;
  String token;

  CompanyModelResponse({
    required this.company,
    required this.token,
  });

  factory CompanyModelResponse.fromJson(Map<String, dynamic> json) => CompanyModelResponse(
    company: Company.fromJson(json["company"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "company": company.toJson(),
    "token": token,
  };
}