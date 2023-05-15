import 'dart:math';

import '../models/service_item_model.dart';

class HomeServices{


  List<ServiceItemModel> generateRandomServiceList(int count) {
    final random = Random();
    final titles = [
      'Service',
      'islam',
      'mohamed'
    ];
    final imageUrls = [
      'https://picsum.photos/id/237/200/300',
      'https://picsum.photos/id/238/200/300',
      'https://picsum.photos/id/239/200/300',
      'https://picsum.photos/id/240/200/300',
      'https://picsum.photos/id/241/200/300',
      'https://picsum.photos/id/242/200/300',
      'https://picsum.photos/id/243/200/300',
    ];

    return List.generate(count, (index) {
      final randomTitleIndex = random.nextInt(titles.length);
      final randomImageUrlIndex = random.nextInt(imageUrls.length);
      return ServiceItemModel(
        title: titles[randomTitleIndex],
        distance: random.nextDouble() * 10, // generate a random distance between 0 and 10 km
        image: imageUrls[randomImageUrlIndex],
        latitude: random.nextDouble() * 90, // generate a random latitude between -90 and 90 degrees
        longitude: random.nextDouble() * 180, description: 'Ay aga', // generate a random longitude between -180 and 180 degrees
      );
    });
  }
}