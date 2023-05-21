import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_project/models/company_model_response.dart';
import 'package:mobile_project/models/company_profile.dart';
import 'package:mobile_project/repos/home_services.dart';

import '../models/company_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'api_status.dart';
class ProfileServices{

  Future getCompany() async {
    String token = await HomeServices().getToken();
    try {
      final response = await http.get(Uri.parse('$BASE/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token'
        },
      );
      if(response.statusCode==200){
        return Success(code: 200,
          response: companyProfileFromJson(response.body),
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException{
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    }
    catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
  Future updateProfile(CompanyProfile model) async {
    String url = '$BASE/update/';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    String token = await HomeServices().getToken() ;
    request.headers['Authorization'] = 'Bearer ${token}'; // Add token to headers
    request.headers['Content-Type'] = 'application/json'; // Add token to headers
    request.fields['company_name'] = model.companyName;
    request.fields['contact_person_name'] = model.contactPersonName;
    request.fields['company_phone'] = model.companyPhone;
    request.fields['email'] = model.email;
    request.fields['company_address'] = model.companyAddress;
    request.fields['company_size'] = model.companySize;
    if(model.password != null) {
      request.fields['password'] = model.password!;
    }
    request.fields['company_industry'] = model.companyIndustry.join(',');
    request.fields['long'] = '${model.long}' ;
    request.fields['lat'] = '${model.lat}' ;
    if(model.image!=null) {
      request.files.add(await http.MultipartFile.fromPath('image', model.image!.path));
    }
    try {
      var response = await request.send();// Replace with your post data
      if(response.statusCode==200){
        return Success(code: 200,
          response: '',
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException{
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    }
    catch (e) {
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
}