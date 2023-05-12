import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/Controllers/sign_up_controller.dart';
import 'package:mobile_project/models/company_model_response.dart';
import 'package:mobile_project/repos/api_status.dart';
import 'package:mobile_project/repos/auth_services.dart';

import '../models/company_model.dart';

class SignUpProvider with ChangeNotifier{
  bool _loading = false ;
  String? _token , _errorMsg;
  CompanyModelResponse? companyModel;

  String? get token => _token;

  bool get loading => _loading;

  final _signUpController = SignUpController();
  final List<String> _selectedIndustries = [];
  final Set<Marker> markers = {};
  String companySize = 'Micro';
  double lat = 0, long =0;


  List<String> get selectedIndustries => _selectedIndustries;
  SignUpController get controller => _signUpController;

  setCompanySize(com){
    companySize = com ;
    notifyListeners();
  }
  setToken(String token){
    _token = token;
    notifyListeners();
  }
  setErrorMsg(String errorMsg){
    _errorMsg = errorMsg;
    notifyListeners();
  }
  setIndustry(value , String ind){
    if(value) {
      _selectedIndustries.add(ind) ;
    } else {
      _selectedIndustries.remove(ind);
    }
    notifyListeners();
  }
  changeMarker(LatLng pos){

    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('marker'),
        position: pos,
      ),
    );
    long = pos.longitude;
    lat = pos.latitude;
    notifyListeners();
  }

  setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

  Future<void> signUp() async {
    setLoading(true) ;
    var model = CompanyModel(
      companyName: _signUpController.companyNameController.text,
      companySize: companySize,
      lat: lat,
      lang: long,
      email: _signUpController.emailController.text,
      companyAddress: _signUpController.companyAddressController.text,
      contactPersonName: _signUpController.contactPersonNameController.text,
      companyPhone: _signUpController.contactPersonPhoneNumberController.text,
      password: _signUpController.passwordController.text,
      companyIndustry: selectedIndustries,
    );

    var response = await AuthServices().register(model) ;
    setLoading(false) ;
    if(response is Success){
      CompanyModelResponse com = response.response as CompanyModelResponse;
      setToken(com.token);
      companyModel = com;
    }else if(response is Failure){
      setErrorMsg(response.errorResponse as String);
    }
  }

  get errorMsg => _errorMsg;
}