import 'package:flutter/material.dart';
import 'package:mobile_project/provider/home_provider.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    var company = provider.curProfile? provider.company : provider.filtered[provider.tappedIndex].company;
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width ;
    var distance = provider.filtered[provider.tappedIndex].distance;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: height*0.15,
              width: height*0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: company.image != null
                      ? AssetImage(company.image!.path)
                      : const AssetImage(
                          'assets/images/buildings.png'), // Replace with your desired background image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              company.companyName.toUpperCase(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.person_2_outlined),
                const SizedBox(width: 10,),
                Text(
                  company.contactPersonName,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.email_outlined,color: Colors.black,),
                  const SizedBox(width: 10,),
                  Text(
                    company.email,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.pin_drop_outlined,color: Colors.black,),
                const SizedBox(width: 10,),
                Text(
                  company.companyAddress,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.code,color: Colors.black,),
                const SizedBox(width: 10,),
                Text(
                  company.companyIndustry,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildRoundedContainer(
                    const Icon(Icons.phone ,color: Color(0xff604BE8),),
                    Text(company.companyPhone),
                  ),
                ),
                const SizedBox(width: 16),
                provider.curProfile? Text("") : Expanded(
                  child: _buildRoundedContainer(
                    Image.asset("assets/images/distance.png" , width: 25,height: 25,),
                    Text('${distance.toStringAsFixed(2)} km'),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: company.services.length,
            itemBuilder: (context, index) {
              final service = company.services[index];
              return ListTile(
                title: Text(service.name),
                subtitle: Text(service.des),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedContainer(Widget icon, Widget text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade200,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          text,
        ],
      ),
    );
  }
}
