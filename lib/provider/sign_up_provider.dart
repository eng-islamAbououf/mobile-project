import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignUpProvider with ChangeNotifier{


  final List<String> _selectedIndustries = [];
  final Set<Marker> markers = {};
  String companySize = 'Micro';
  double lang = 0 , lat = 0;
  List<String> get selectedIndustries => _selectedIndustries;

  setCompanySize(com){
    companySize = com ;
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
    lang = pos.longitude;
    lat = pos.latitude;
    notifyListeners();
  }
}