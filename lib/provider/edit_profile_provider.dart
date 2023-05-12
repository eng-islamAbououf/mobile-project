import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/api.dart';
import 'package:mobile_project/model/company_model.dart';

class EditProfileProvider with ChangeNotifier{

  final CompanyModel _companyModel = CompanyModel(
      'swsws',
      'abdo',
      '01118210115',
      'abdelrahmn@gmail.com',
      'sheko', 'Large',
      '123456789', ['Industry1'], null , 0 , 0);


  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _password = TextEditingController();
  final _addressController = TextEditingController();

  CompanyModel get companyModel => _companyModel;

  get formKey => _formKey;

  init(){
    _nameController.text = companyModel.companyName!;
    _contactNameController.text = companyModel.contactPersonName!;
    _phoneNumberController.text = companyModel.phoneNumber!;
    _emailController.text = companyModel.email!;
    _password.text = companyModel.password!;
    _addressController.text = companyModel.address!;
  }
  setImage(var image) async {
    _companyModel.image = image ;
    notifyListeners();
  }

  setSize(var size){
    _companyModel.size = size;
    notifyListeners();
  }

  setIndustry(value, industry){
    if(value) {
      companyModel.industry!.add(industry) ;
    } else {
      if(companyModel.industry!.length>1) {
        companyModel.industry!.remove(industry);
      }
    }
    notifyListeners();
  }

  saveChanges() async {

    var response = await Api().editCompanyProfile(_companyModel) ;
    print(response) ;
  }

  get nameController => _nameController;

  get contactNameController => _contactNameController;

  get phoneNumberController => _phoneNumberController;

  get emailController => _emailController;

  get password => _password;

  get addressController => _addressController;
}