import 'package:flutter/cupertino.dart';

class SignUpProvider with ChangeNotifier{


  List<String> _selectedIndustries = [];
  String companySize = 'Micro';

  List<String> get selectedIndustries => _selectedIndustries;

  setCompanySize(var com){
    companySize = com ;
    notifyListeners();
  }
  setIndustry(var value , String ind){
    if(value) _selectedIndustries.add(ind) ;
    else _selectedIndustries.remove(ind);
    notifyListeners();
  }
}