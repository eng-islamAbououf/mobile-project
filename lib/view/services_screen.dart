import 'package:flutter/material.dart';
import 'package:mobile_project/componants/service_item_view.dart';
import 'package:mobile_project/provider/home_provider.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<HomeProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextField(
            onChanged: (val){
              provider.setSearchText(val);
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
        Expanded(
          child: ListView.builder(
            itemCount: provider.filtered.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  provider.setTappedIndex(index);
                  provider.setIndex(SERVICE_DETAILS_PAGE);
                },
                  child: ServiceItemView(model: provider.filtered[index])
              );
            },
          ),
        ),
      ],
    );
  }
}
