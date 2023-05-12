import 'dart:convert';
import 'dart:io';

import 'package:mobile_project/models/company_model_response.dart';
import 'package:mobile_project/repos/api_status.dart';
import 'package:mobile_project/utils/constants.dart';

import '../models/company_model.dart';
import 'package:http/http.dart' as http;

class AuthServices{

  Future login(String email , String password) async {
    String url = '$BASE/login/';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email' : email,
          'password' : password
        }),
      );

      print(response.body);
      if(response.statusCode==200){
        return Success(code: 200,
            response: companyResponseFromJson(response.body),
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
  Future<Object> register(CompanyModel model) async {
    String url = '$BASE/register/';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: companyToJson(model),
      );
      if(response.statusCode==201){
        return Success(code: 200, response: companyResponseFromJson(response.body));
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Data");
    } on HttpException{
      return Failure(code: NO_INTERNE, errorResponse: "No Internet");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    }
    catch (e) {
      print(e);
      return Failure(code: UNKNOWN, errorResponse: "Unknown Error");
    }
  }
}