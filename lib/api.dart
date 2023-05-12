import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_project/model/company_model.dart';

class Api{

  Future<void> createCompany(CompanyModel model) async {
    const String url = 'https://example.com/api/posts';
    final Map<String, dynamic> postData = model.toJson(); // Replace with your post data

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        // POST request successful
        print('POST request successful');
        print(response.body); // Response body as String
        final Map<String, dynamic> responseData = jsonDecode(response.body); // Response body as Map
        print(responseData); // Response body as Map
      } else {
        // POST request unsuccessful
        print('POST request unsuccessful');
        print(response.body); // Response body as String
      }
    } catch (e) {
      // Exception occurred while sending POST request
      print('Exception occurred while sending POST request: $e');
    }
  }

}