import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Model/garage.dart';
import 'package:garage/Model/item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GarageProvider extends ChangeNotifier {
  final List<Marker> _garageMarkers = [];
  List<Marker> get garageMarkers => _garageMarkers;

  final List<Garage> _garages = [];
  List<Garage> get garages => _garages;

  TempGarage? tempGarage;

  void addTempGarage(String name, double lat, double lng, List<File> images, String address, String phone, List<String> openingHours){
    tempGarage=TempGarage(name: name, lat: lat, lng: lng, images: images, address: address, phone: phone, openingHours: openingHours);
  }

  void addGarage(
    String name,
    double lat,
    double lng,
    List<String> images,
    String address,
    String phone,
    List<String> openingHours,
    List<String> categories,
  ) {
    _garages.add(Garage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      lat: lat,
      lng: lng,
      images: images,
      address: address,
      phone: phone,
      openingHours: openingHours,
      categories: categories,
      categoryItems: {},
    ));
    notifyListeners();
  }

  void addGarageMarkers(String name, double lat, double lng) {
    final marker = Marker(
      markerId: MarkerId(name),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(
        title: name,
        snippet: "Tap for details",
        onTap: () {
          // This will be handled in MapScreen using onTap on marker
        },
      ),
    );
    _garageMarkers.add(marker);
    notifyListeners();
  }

  final Map<String, List<InventoryItem>> _inventory = {
    "Battery": [],
    "AC": [],
    "Brake": [],
    "Clutch": [],
    "Tyre": [],
  };

  Map<String, List<InventoryItem>> get inventory => _inventory;

  List<InventoryItem> getItemByCategory(String category) {
    return _inventory[category] ?? [];
  }

  void addItem(InventoryItem item) {
    if (_inventory.containsKey(item.category)) {
      _inventory[item.category]!.add(item);
    } else {
      _inventory[item.category] = [item];
    }
    notifyListeners();
  }

  void addCategoryItemsToGarage(
    String garageId, Map<String, Map<String, Map<String, dynamic>>> items) {
  final garage = _garages.firstWhere((g) => g.id == garageId);
  garage.categoryItems.addAll(items);
  notifyListeners();
}

  
}
