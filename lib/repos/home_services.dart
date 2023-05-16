import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:mobile_project/models/company_model.dart';
import 'package:mobile_project/models/service_response.dart';
import 'package:mobile_project/utils/constants.dart';

import '../models/service_item_model.dart';
import 'package:http/http.dart' as http ;

import 'api_status.dart';

class HomeServices{


  Future<String> getToken() async {
    var box =await Hive.openBox('myBox');
    return box.get('token');
  }
  // List<ServiceItemModel> generateRandomServiceList(int count) {
  //   final random = Random();
  //   final titles = [
  //     'Service',
  //     'islam',
  //     'mohamed'
  //   ];
  //   final imageUrls = [
  //     'https://picsum.photos/id/237/200/300',
  //     'https://picsum.photos/id/238/200/300',
  //     'https://picsum.photos/id/239/200/300',
  //     'https://picsum.photos/id/240/200/300',
  //     'https://picsum.photos/id/241/200/300',
  //     'https://picsum.photos/id/242/200/300',
  //     'https://picsum.photos/id/243/200/300',
  //   ];
  //
  //   return List.generate(count, (index) {
  //     final randomTitleIndex = random.nextInt(titles.length);
  //     final randomImageUrlIndex = random.nextInt(imageUrls.length);
  //     return ServiceItemModel(
  //       service: Service(id: random.nextInt(count),
  //           companyId: random.nextInt(count),
  //           des:"Ay 7aga",
  //           name: titles[randomTitleIndex]),
  //       distance: random.nextDouble() * 10,
  //       company: Company(
  //         image: null,
  //         companySize: "Large",
  //         companyAddress: "6th of October",
  //         companyName: "Semsark",
  //         companyPhone: "01032783297",
  //         companyIndustry: ["i1" , "i2"] ,
  //         contactPersonName: "islam Abououf",
  //         email: "islam@gmail.com",
  //         lat: 0,
  //         long: 0, id: "1"
  //       ),// generate a random distance between 0 and 10 km
  //     );
  //   });
  // }

  Future<List<ServiceItemModel>> getAllServices(double long , double lat) async {

    String token = await getToken();
    final response = await http.get(Uri.parse('$BASE/getAllServices/$lat/$long'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization' : 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List<ServiceResponse> services = serviceFromJson(response.body);
      List<ServiceItemModel> ret = [];
      services.forEach((res) {
        res.company.services.forEach((service) {
          ret.add(ServiceItemModel(service: service, company: res.company, distance: res.distance));
        });
      }) ;
      return ret;
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future addService(title, desc) async {
    String url = '$BASE/addService/';
    String token = await getToken() ;
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token'
        },
        body: jsonEncode({
          'name' : title,
          'des' : desc
        }),
      );
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

  Future getCompany() async {
    String url = '$BASE/user';
    String token = await getToken() ;
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token'
        },
      );
      if(response.statusCode==200){
        return Success(code: 200,
          response: Company.fromJson(jsonDecode(response.body)),
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

  Future getCompanyByID(id) async {
    String url = '$BASE/user';
    String token = await getToken() ;
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token'
        },
      );
      if(response.statusCode==200){
        return Success(code: 200,
          response: Company.fromJson(jsonDecode(response.body)),
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