import 'package:flutter/material.dart';
import 'package:mobile_project/models/service_item_model.dart';

import '../models/service_response.dart';

class CompanyItemView extends StatelessWidget {
  CompanyItemView({Key? key , required this.model}) : super(key: key);

  Company model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
          border: Border.all(color: Color(0xff604BE8),)
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset("assets/images/buildings.png",
            width: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.companyName.toUpperCase(),
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
                  Text(model.contactPersonName ,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.pin_drop_outlined,color: Color(0xff604BE8),),
                  const SizedBox(width: 10,),
                  Text(model.companyAddress),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
