import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _services = [];
  List<Map<String, dynamic>> get services => _services;

  final Map<String, String> serviceImageMap = {
    "Basic Servicing": "assets/Service_Booking/Basic_Servicing.png",
    "Standard Servicing": "assets/Service_Booking/Standard_Servicing.png",
    "Comprehensive Servicing":
        "assets/Service_Booking/Comperhensive_Scervicing.png",
  };

  double get totalAmount =>
      _services.fold(0, (sum, item) => sum + item["price"]);

  void addService(String name, double price) {
    _services.add({"name": name, "price": price});
    notifyListeners();
  }

  void removeService(String name) {
    _services.removeWhere((item) => item["name"] == name);
    notifyListeners();
  }

  void clear() {
    _services.clear();
    notifyListeners();
  }
}
