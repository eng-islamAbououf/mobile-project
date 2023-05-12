
import 'dart:io';

class CompanyModel{
  String? companyName;
  String? contactPersonName;
  String? phoneNumber;
  String? email;
  String? address;
  String? size;
  String? password;


  double lat , lang ;
  File? image;
  List<String>? industry;


  CompanyModel(this.companyName, this.contactPersonName, this.phoneNumber,
      this.email, this.address, this.size, this.password, this.industry , this.image
      , this.lat , this.lang
      );

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      json['company_name'] as String?,
      json['contact_person_name'] as String?,
      json['company_phone'] as String?,
      json['email'] as String?,
      json['company_address'] as String?,
      json['company_size'] as String?,
      json['password'] as String?,
      (json['company_industry'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['image'],
      json['lat'],
      json['lang']
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'company_name': companyName,
      'contact_person_name': contactPersonName,
      'company_phone': phoneNumber,
      'email': email,
      'company_address': address,
      'company_size': size,
      'password': password,
      'company_industry': industry!.toList(),
      'lat' : lat ,
      'lang' : lang
    };
  }
}
