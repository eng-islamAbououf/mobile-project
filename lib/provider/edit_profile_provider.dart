import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_project/model/company_model.dart';

class EditProfileProvider with ChangeNotifier{

  final CompanyModel _companyModel = CompanyModel('islam',
      'solom',
      '01032783297',
      'email@gmail.com',
      'tanta', 'Micro',
      'password', ['Industry 1'], null);

  CompanyModel get companyModel => _companyModel;

  setImage(var image){
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
      if(companyModel.industry!.length>1)
        companyModel.industry!.remove(industry);
    }
    notifyListeners();
  }


}