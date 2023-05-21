import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mobile_project/Controllers/sign_in_controller.dart';
import 'package:mobile_project/Controllers/sign_up_controller.dart';
import 'package:mobile_project/models/company_model_response.dart';
import 'package:mobile_project/repos/api_status.dart';
import 'package:mobile_project/repos/auth_services.dart';

import '../models/company_model.dart';

class SignInProvider with ChangeNotifier{
  bool _loading = false ;
  String? _errorMsg;
  CompanyModelResponse? companyModel;

  bool get loading => _loading;

  final _controller = SignInController();

  get controller => _controller;

  setErrorMsg(String errorMsg){
    _errorMsg = errorMsg;
    notifyListeners();
  }

  setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

  Future<void> signIn() async {
    setLoading(true) ;
    var response = await AuthServices().login(_controller.emailController.text , _controller.passwordController.text) ; ;

    print(response) ;
    if(response is Success){
      CompanyModelResponse com = response.response as CompanyModelResponse;
      var box =await Hive.openBox('myBox');
      box.put('token', com.token);
      companyModel = com;
    }else if(response is Failure){
      setErrorMsg(response.errorResponse as String);
    }
    setLoading(false) ;
  }

  get errorMsg => _errorMsg;
}