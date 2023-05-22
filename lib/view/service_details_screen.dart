import 'package:flutter/material.dart';
import 'package:mobile_project/models/service_item_model.dart';
import 'package:mobile_project/provider/home_provider.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:provider/provider.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    ServiceItemModel model = provider.services[provider.tappedIndex-1];
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Name
            Row(
              children: [
                Text(
                  model.service.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: (){
                    provider.addToFav();
                  },
                  icon: Icon(
                    provider.fav_services.contains(provider.tappedIndex) ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xff604BE8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Phone Number and Distance
            Row(
              children: [
                Expanded(
                  child: _buildRoundedContainer(
                    const Icon(Icons.phone ,color: Color(0xff604BE8),),
                    Text(model.company.companyPhone),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildRoundedContainer(
                    Image.asset("assets/images/distance.png" , width: 25,height: 25,),
                    Text('${model.distance.toStringAsFixed(2)} km'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Company Name, Contact Name, and Address
            InkWell(
              onTap: (){
                provider.setCurProfile(false) ;
                provider.setIndex(PROFILE_PAGE);
              },
              child: _buildRoundedCard(
                Row(
                  children: [
                    model.company.image == null?Image.asset(
                      "assets/images/buildings.png",
                      width: 70,
                      fit: BoxFit.cover,
                    ) :
                    CircleAvatar(
                      radius: 35, // Adjust the radius according to your preference
                      backgroundImage: FileImage(model.company.image!),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.company.companyName.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.account_circle_outlined,color: Color(0xff604BE8),),
                            const SizedBox(width: 10,),
                            Text(model.company.contactPersonName ,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.pin_drop_outlined,color: Color(0xff604BE8),),
                            const SizedBox(width: 10,),
                            Text(model.company.companyAddress),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Service Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              model.service.des,
              style: const TextStyle(fontSize: 16),
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

  Widget _buildRoundedCard(Widget child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        border: Border.all(color: Color(0xff604BE8),)
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

}
