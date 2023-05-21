import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/componants/company_item_view.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class SearchCompanyScreen extends StatelessWidget {
  const SearchCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<HomeProvider>(context);
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width ;
    final Completer<GoogleMapController> mapController = Completer();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextField(
            onChanged: (val){
              provider.setSearchCompany(val);
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.filter_list),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        ElevatedButton(onPressed: (){
          provider.setMapListView();
        },
          child: SizedBox(
            width: width*0.25,
            child: provider.mapView ? Row(
              children: const [
                Icon(Icons.list),
                Text('List View'),
              ],
            ) : Row(
              children: const [
                Icon(Icons.map_outlined),
                Text('Map View'),
              ],
            ),
          ),
        ),
        provider.filteredCompany.isEmpty ? const Center(child: Text("No Such Companies")) : provider.mapView ? SizedBox(
          width: width,
          height: height * 0.632,
          child: GoogleMap(
            initialCameraPosition:
            CameraPosition(
             // target: LatLng(provider.position!.latitude,provider.position!.longitude),
              target: provider.markers.isEmpty ? const LatLng(0, 0) : provider.markers.first.position,
              zoom: 16,
            ),
            markers: provider.markers,
            onMapCreated:
                (GoogleMapController controller) {
              if(mapController.isCompleted) {
                mapController
                    .complete(controller);
              }
            },
            onCameraMove: (po) {},
          ),
        ):Expanded(
          child: ListView.builder(
            itemCount: provider.filteredCompany.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: (){
                    provider.getProfile(provider.filteredCompany[index]);
                    provider.setCurProfile(false) ;
                    provider.setIndex(PROFILE_PAGE);
                  },
                  child: CompanyItemView(model: provider.filteredCompany[index])
              );
            },
          ),
        ),
      ],
    );
  }
}
