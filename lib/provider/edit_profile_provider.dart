import 'package:flutter/material.dart';
import 'package:mobile_project/Controllers/edit_profile_controller.dart';
import 'package:mobile_project/models/company_model_response.dart';
import 'package:mobile_project/models/company_profile.dart';
import 'package:mobile_project/repos/profile_services.dart';

import '../repos/api_status.dart';

class EditProfileProvider with ChangeNotifier{

  late CompanyProfile _companyModel;
  bool _loading = false;
  bool _success = false;
  String? errorMsg;
  bool get loading => _loading;
  final EditProfileController _controller = EditProfileController();
  CompanyProfile get companyModel => _companyModel;

  EditProfileProvider(){
    init();
  }
  init() async{
    setLoading(true) ;
    var response = await ProfileServices().getCompany();
    if(response is Success) {
      _companyModel = response.response as CompanyProfile ;
    }
    _controller.nameController.text = _companyModel.companyName;
    _controller.contactNameController.text = _companyModel.contactPersonName;
    _controller.phoneNumberController.text = _companyModel.companyPhone;
    _controller.emailController.text = _companyModel.email;
    _controller.password.text = "islam1234";
    _controller.addressController.text = _companyModel.companyAddress;
    setLoading(false);
  }
  setImage(var image) async {
    _companyModel.image = image ;
    notifyListeners();
  }

  setSize(var size){
    _companyModel.companySize = size;
    notifyListeners();
  }

  setIndustry(value, industry){
    if(value) {
      companyModel.companyIndustry.add(industry) ;
    } else {
      if(companyModel.companyIndustry.length>1) {
        companyModel.companyIndustry.remove(industry);
      }
    }
    notifyListeners();
  }

  updateProfile() async {
    if(_controller.password.text != "islam1234") {
      companyModel.password = _controller.password.text;
    }
    setLoading(true) ;
    var response = await ProfileServices().updateProfile(_companyModel) ;
    setLoading(false) ;
    if(response is Success){
      _success = true;
    }else {
      errorMsg = 'Some Error' ;
    }
    notifyListeners();
  }

  bool get success => _success;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  EditProfileController get controller => _controller;
}