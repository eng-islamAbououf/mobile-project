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
    return Card(
      elevation: 0, // Removes the shadow
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.only(
          left: 10,
          top: 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.service.name.toUpperCase(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const SizedBox(
                    height: 25,
                  width: 25,
                    child: Image(
                      image: AssetImage("assets/images/distance.png"),
                      fit: BoxFit.cover,
                    ),
                ),
                Expanded(
                  child: Text(
                    ' ${model.distance.toStringAsFixed(2)} km',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () => _openInMaps(),
                    icon: const Icon(Icons.directions),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openInMaps() async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${model.company.lat},${model.company.long}';
    if (await canLaunchUrlString(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
