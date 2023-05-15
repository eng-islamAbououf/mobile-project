import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/service_item_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServiceItemView extends StatelessWidget {
  ServiceItemView({Key? key, required this.model}) : super(key: key);

  ServiceItemModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            model.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                        height: 25,
                      width: 25,
                        child: Image.asset("assets/icons/distance.png"),
                    ),
                    Text(
                      ' ${model.distance.toStringAsFixed(2)} km',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () => _openInMaps(),
                    icon: const Icon(Icons.directions),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openInMaps() async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${model.latitude},${model.longitude}';
    if (await canLaunchUrlString(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
