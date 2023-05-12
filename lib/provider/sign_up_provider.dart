import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignUpProvider with ChangeNotifier{


  List<String> _selectedIndustries = [];
  final Set<Marker> markers = {};
  String companySize = 'Micro';

  List<String> get selectedIndustries => _selectedIndustries;

  setCompanySize(var com){
    companySize = com ;
    notifyListeners();
  }
  setIndustry(var value , String ind){
    if(value) {
      _selectedIndustries.add(ind) ;
    } else {
      _selectedIndustries.remove(ind);
    }
    notifyListeners();
  }

  changeMarker(pos){

    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('new-position'),
        position: pos,
      ),
    );
    notifyListeners();
  }
}