import 'package:flutter/material.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:provider/provider.dart';

import '../componants/service_item_view.dart';
import '../provider/home_provider.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<HomeProvider>(context);
    return ListView.builder(
      itemCount: provider.fav_services.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            provider.setTappedIndex(provider.fav_services[index]);
            provider.setIndex(SERVICE_DETAILS_PAGE);
          },
            child: ServiceItemView(
                model: provider.services[provider.fav_services[index]-1]));
      },
    );
  }
}
