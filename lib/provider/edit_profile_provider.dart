import 'package:flutter/material.dart';
import 'package:mobile_project/Controllers/edit_profile_controller.dart';
import 'package:mobile_project/models/company_model_response.dart';
import 'package:mobile_project/repos/profile_services.dart';

import '../repos/api_status.dart';

class EditProfileProvider with ChangeNotifier{

  late CompanyModelResponse _companyModel;
  bool _loading = false;
  bool _success = false;
  String? errorMsg;
  bool get loading => _loading;
  final EditProfileController _controller = EditProfileController();
  CompanyModelResponse get companyModel => _companyModel;

  init(CompanyModelResponse model){
    _companyModel = model;
    _controller.nameController.text = _companyModel.company.companyName;
    _controller.contactNameController.text = _companyModel.company.contactPersonName;
    _controller.phoneNumberController.text = _companyModel.company.companyPhone;
    _controller.emailController.text = _companyModel.company.email;
    _controller.password.text = _companyModel.company.password??' ';
    _controller.addressController.text = _companyModel.company.companyAddress;
  }
  setImage(var image) async {
    _companyModel.company.image = image ;
    notifyListeners();
  }

  setSize(var size){
    _companyModel.company.companySize = size;
    notifyListeners();
  }

  setIndustry(value, industry){
    if(value) {
      companyModel.company.companyIndustry.add(industry) ;
    } else {
      if(companyModel.company.companyIndustry.length>1) {
        companyModel.company.companyIndustry.remove(industry);
      }
    }
    notifyListeners();
  }

  updateProfile() async {
    companyModel.company.password = _controller.password.text;
    setLoading(true) ;
    var response = await ProfileServices().updateProfile(companyModel) ;
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