import 'dart:convert';

import 'package:mobile_project/models/company_model.dart';

CompanyModelResponse companyResponseFromJson(String str) => CompanyModelResponse.fromJson(json.decode(str));

String companyResponseToJson(CompanyModelResponse data) => json.encode(data.toJson());

class CompanyModelResponse{

  CompanyModel company;
  String token;

  CompanyModelResponse({
    required this.company,
    required this.token,
  });

  factory CompanyModelResponse.fromJson(Map<String, dynamic> json) => CompanyModelResponse(
    company: CompanyModel.fromJson(json["company"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "company": company.toJson(),
    "token": token,
  };
}