import 'dart:io';

import 'package:mobile_project/models/company_model_response.dart';

import '../models/company_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'api_status.dart';
class ProfileServices{

  Future updateProfile(CompanyModelResponse companyModel) async {
    String url = '$BASE/update/';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    CompanyModel model = companyModel.company;
    print(model);
    request.headers['Authorization'] = 'Bearer ${companyModel.token}'; // Add token to headers
    request.headers['Content-Type'] = 'application/json'; // Add token to headers
    request.fields['company_name'] = model.companyName;
    request.fields['contact_person_name'] = model.contactPersonName;
    request.fields['company_phone'] = model.companyPhone;
    request.fields['email'] = model.email;
    request.fields['company_address'] = model.companyAddress;
    request.fields['company_size'] = model.companySize;
    request.fields['password'] = model.password!;
    request.fields['company_industry'] = model.companyIndustry.join(',');
    request.fields['lang'] = '${model.lang}' ;
    request.fields['lat'] = '${model.lat}' ;
    if(model.image!=null)
      request.files.add(await http.MultipartFile.fromPath('image', model.image!.path));
    print(request.fields) ;
    try {
      var response = await request.send();// Replace with your post data
      var responseData = await http.Response.fromStream(response);
      if(response.statusCode==200){
        return Success(code: 200,
          response: '',
        );
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Email or password");
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