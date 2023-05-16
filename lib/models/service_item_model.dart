import 'dart:convert';

import 'package:mobile_project/models/company_model.dart';
import 'package:mobile_project/models/service_response.dart';

List<ServiceItemModel> serviceItemModelFromJson(String str) => List<ServiceItemModel>.from(json.decode(str).map((x) => ServiceItemModel.fromJson(x)));

String serviceItemModelToJson(List<ServiceItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceItemModel {
  Service service;
  Company company;
  double distance;

  ServiceItemModel({
    required this.service,
    required this.company,
    required this.distance
  });

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) => ServiceItemModel(
    service: Service.fromJson(json["service"]),
    company: Company.fromJson(json["company"]),
    distance: json['distance']
  );

  Map<String, dynamic> toJson() => {
    "service": service.toJson(),
    "company": company.toJson(),
    "distance" : distance
  };
}
class Service {
  int id;
  int companyId;
  String des;
  String name;

  Service({
    required this.id,
    required this.companyId,
    required this.des,
    required this.name,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    companyId: json["company_id"],
    des: json["des"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "des": des,
    "name": name,
  };
}
