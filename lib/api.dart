import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_project/model/company_model.dart';

class Api{

  String base="http://127.0.0.1:8000/api";

  Future login(String email , String password) async {
    String url = '$base/login/';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email' : email,
          'password' : password
        }),
      );
      return {
          'status' : response.statusCode ==200 ,
          'body' : response.body ,
        } ;// Response body as Map
    } catch (e) {
      // Exception occurred while sending POST request
      print('Exception occurred while sending POST request: $e');
    }
  }
  Future createCompany(CompanyModel model) async {
    String url = '$base/register/';
    final Map<String, dynamic> postData = model.toJson(); // Replace with your post data

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );
      return {
        'status' : response.statusCode ==201 ,
        'body' : response.body ,
      } ;
    } catch (e) {
      // Exception occurred while sending POST request
      print('Exception occurred while sending POST request: $e');
    }
  }
  Future editCompanyProfile(CompanyModel model) async {
    String url = '$base/update/';
    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL3JlZ2lzdGVyIiwiaWF0IjoxNjgzODYyNTg4LCJleHAiOjE2ODM4ODQxODgsIm5iZiI6MTY4Mzg2MjU4OCwianRpIjoiOFVRN0VaZE1sQ29Yc0VGNiIsInN1YiI6IjEiLCJwcnYiOiJjZmU3ZWM5OWEyM2Y0Mzg4ZTdmMWQ1ZmI4NzA4Mzc1Yzg1NGVkYTY0In0.xNm6ThzsaETDO9LmZJxLZZBMlHL7va0VETKQqPXGJcI" ;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token'; // Add token to headers
    request.headers['Content-Type'] = 'application/json'; // Add token to headers
    request.fields['company_name'] = model.companyName!;
    request.fields['contact_person_name'] = model.contactPersonName!;
    request.fields['company_phone'] = model.phoneNumber!;
    request.fields['email'] = model.email!;
    request.fields['company_address'] = model.address!;
    request.fields['company_size'] = model.size!;
    request.fields['password'] = model.password!;
    request.fields['company_industry'] = '${model.industry}';
    request.fields['lang'] = '${model.lang}' ;

    request.files.add(await http.MultipartFile.fromPath('image', model.image!.path));
    print(request.fields) ;
    try {
      var response = await request.send();// Replace with your post data
      var responseData = await http.Response.fromStream(response);
      return {
        'status' : response.statusCode ==200 ,
        'body' : responseData.body ,
      };
    } catch (e) {
      // Exception occurred while sending POST request
      print('Exception occurred while sending POST request: $e');
    }
  }

}