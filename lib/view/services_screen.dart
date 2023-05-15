import 'package:flutter/material.dart';
import 'package:mobile_project/componants/service_item_view.dart';
import 'package:mobile_project/provider/home_provider.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({Key? key ,required this.provider}) : super(key: key);

  HomeProvider provider;
  @override
  Widget build(BuildContext context) {
    double height  = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextField(
            controller: provider.searchController,
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
        SizedBox(
          height: height*0.65,
          child: ListView.builder(
            itemCount: provider.filtered.length,
            itemBuilder: (context, index) {
              return ServiceItemView(model: provider.filtered[index]);
            },
          ),
        ),
      ],
    );
  }
}
