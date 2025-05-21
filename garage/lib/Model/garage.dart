import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class TempGarage{
  final String name;
  final double lat;
  final double lng;
  final List<File> images;
  final String address;
  final String phone;
  final List<String> openingHours;

  TempGarage({
    required this.name,
    required this.lat,
    required this.lng,
    required this.images,
    required this.address,
    required this.phone,
    required this.openingHours,
  });
}
class Garage {
  final String name;
  final double lat;
  final double lng;
  final List<String> images;
  final String address;
  final String phone;
  final List<String> openingHours;
  final List<String> categories;
  Map<String, Map<String, Map<String, dynamic>>> categoryItems;
  final String id;

  Garage({
    required this.name,
    required this.lat,
    required this.lng,
    required this.images,
    required this.address,
    required this.phone,
    required this.openingHours,
    required this.categories,
    required this.categoryItems,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "location": {
        "lat": lat,
        "lng": lng,
      },
      "address": address,
      "phone": phone,
      "openingHours": openingHours,
      "categories": categories,
    };
  }

  factory Garage.fromMap(Map<String, dynamic> map) {
    return Garage(
      name: map["name"],
      lat: map["location"]["lat"],
      lng: map["location"]["lng"],
      images: List<String>.from(map["images"] ?? []),
      address: map["address"],
      phone: map["phone"],
      openingHours: List<String>.from(map["openingHours"] ?? []),
      categories: List<String>.from(map["categories"] ?? []),
      categoryItems: map["categoryItems"] != null
          ? (map["categoryItems"] as Map<String, dynamic>).map(
              (category, itemsMap) => MapEntry(
                category,
                (itemsMap as Map<String, dynamic>).map(
                  (itemName, details) => MapEntry(
                    itemName,
                    Map<String, dynamic>.from(details),
                  ),
                ),
              ),
            )
          : {},
      id: map["id"] ?? "",
    );
  }
}
