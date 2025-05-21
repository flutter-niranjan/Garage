import 'dart:io';

class InventoryItem {
  String name;
  String description;
  String category;
  double price;
  String imagePath;
  File? image;


  InventoryItem(
      {required this.name,
      required this.description,
      required this.category,
      required this.price,
      required this.imagePath,
      required this.image,
      });
}
