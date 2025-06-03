import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _services = [];
  List<Map<String, dynamic>> get services => _services;

  String? _garageName;
  String? get garageName => _garageName;

  final Map<String, String> serviceImageMap = {
    "Basic Servicing": "assets/Service_Booking/Basic_Servicing.png",
    "Standard Servicing": "assets/Service_Booking/Standard_Servicing.png",
    "Comprehensive Servicing":
        "assets/Service_Booking/Comprehensive_Servicing.png",
  };

  double get totalAmount => _services.fold(
      0.0,
      (sum, item) =>
          sum +
          ((item["price"] is num)
                  ? item["price"].toDouble()
                  : double.tryParse(item["price"].toString()) ?? 0.0) *
              (item["count"] ?? 1));

  void addService(String name, double price, String imagePath,
      {String? garageName, BuildContext? context}) {
    if (_garageName != null &&
        garageName != null &&
        _garageName != garageName) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "You can only add items from $_garageName. Please clear your cart to add items from other garages.")),
        );
      }
      return;
    }
    if (_garageName == null && garageName != null) {
      _garageName = garageName;
    }
    _services.add({"name": name, "price": price, "imagePath": imagePath});
    notifyListeners();
  }

  bool addItem(Map<String, dynamic> item,
      {String? garageName, BuildContext? context}) {
    if (_garageName != null &&
        garageName != null &&
        _garageName != garageName) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "You can only add items from $_garageName. Please clear your cart to add items from other garages.")),
        );
      }
      return false;
    }
    if (_garageName == null && garageName != null) {
      _garageName = garageName;
    }
    final index = _services.indexWhere((e) => e["name"] == item["name"]);
    if (index != -1) {
      _services[index]["count"] = item["count"];
    } else {
      _services.add(item);
    }
    notifyListeners();
    return true;
  }

  void removeService(String name) {
    _services.removeWhere((item) => item["name"] == name);
    if (_services.isEmpty) {
      _garageName = null;
    }
    notifyListeners();
  }

  void setGarageName(String name) {
    _garageName = name;
    notifyListeners();
  }

  void decrementItem(String name) {
    final index = _services.indexWhere((item) => item["name"] == name);
    if (index != -1) {
      if (_services[index]["count"] != null && _services[index]["count"] > 1) {
        _services[index]["count"] -= 1;
      } else {
        _services.removeAt(index);
      }
      if (_services.isEmpty) {
        _garageName = null;
      }
      notifyListeners();
    }
  }

  void clear() {
    _services.clear();
    _garageName = null;
    notifyListeners();
  }
}
