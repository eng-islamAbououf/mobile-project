
import 'dart:io';

class CompanyModel {
  String? companyName;
  String? contactPersonName;
  String? phoneNumber;
  String? email;
  String? address;
  String? size;
  String? password;
  File? image;
  List<String>? industry;


  CompanyModel(this.companyName, this.contactPersonName, this.phoneNumber,
      this.email, this.address, this.size, this.password, this.industry , this.image);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      json['companyName'] as String?,
      json['contactPersonName'] as String?,
      json['phoneNumber'] as String?,
      json['email'] as String?,
      json['address'] as String?,
      json['size'] as String?,
      json['password'] as String?,
      (json['industry'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'companyName': companyName,
      'contactPersonName': contactPersonName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'size': size,
      'password': password,
      'industry': industry,
    };
  }
}
