import 'package:flutter/material.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Screens/Profile/specific_item.dart';
import 'package:provider/provider.dart';

class AddInventory extends StatefulWidget {
  final String name;
  final double lat;
  final double lng;
  final List<String> images;
  final String address;
  final String phone;
  final List<String> openingHours;
  const AddInventory({
    super.key,
    required this.name,
    required this.lat,
    required this.lng,
    required this.images,
    required this.address,
    required this.phone,
    required this.openingHours,
  });

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  final List<String> categories = [
    "AC",
    "Battery",
    "Brake",
    "Clutch",
    "Glass",
    "Lights",
    "Suspension",
    "Tyres"
  ];
  final Set<String> selectedCategory = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Inventory"),
      ),
      body: ListView(
        children: categories.map((category) {
          return CheckboxListTile(
            title: Text(category),
            value: selectedCategory.contains(category),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedCategory.add(category);
                } else {
                  selectedCategory.remove(category);
                }
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          // Save the garage with selected categories
          final garageProvider =
              Provider.of<GarageProvider>(context, listen: false);
          garageProvider.addGarage(
            widget.name,
            widget.lat,
            widget.lng,
            widget.images,
            widget.address,
            widget.phone,
            widget.openingHours,
            selectedCategory.toList(),
          );
          // Get the id of the last added garage
          final garageId = garageProvider.garages.last.id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecificItem(
                garageId: garageId, // Pass the garageId here
                selectedCategories: selectedCategory.toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
