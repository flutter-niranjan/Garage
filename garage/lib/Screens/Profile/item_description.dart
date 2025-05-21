import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:garage/firebasedataupload.dart';

class ItemDescription extends StatefulWidget {
  final Map<String, Set<String>> selectedItem;
  final String garageId;
  const ItemDescription(
      {super.key, required this.selectedItem, required this.garageId});

  @override
  State<ItemDescription> createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  final Map<String, Map<String, Map<String, dynamic>>> itemDetails = {};
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var category in widget.selectedItem.keys) {
      itemDetails[category] = {};
      for (var item in widget.selectedItem[category]!) {
        itemDetails[category]![item] = {
          "description": "",
          "price": "",
          "image": null,
        };
      }
    }
  }

  Future<void> pickImage(String category, String item) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        itemDetails[category]![item]!["image"] = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Details"),
      ),
      body: ListView(
        children: widget.selectedItem.entries.expand((entry) {
          final category = entry.key;
          return entry.value.map((item) {
            final details = itemDetails[category]![item]!;
            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$category - $item",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => pickImage(category, item),
                      child: details["image"] != null
                          ? Image.file(details["image"], height: 150)
                          : Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey,
                              child: const Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      onChanged: (value) {
                        itemDetails[category]![item]!["description"] = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        itemDetails[category]![item]!["price"] = value;
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          // Add "name" to each item's details before saving
          final updatedItemDetails =
              <String, Map<String, Map<String, dynamic>>>{};
          itemDetails.forEach((category, items) {
            updatedItemDetails[category] = {};
            items.forEach((item, details) {
              updatedItemDetails[category]![item] = {
                ...details,
                "name": item, // Add the name here
              };
            });
          });

          Provider.of<GarageProvider>(context, listen: false)
              .addCategoryItemsToGarage(widget.garageId, updatedItemDetails);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Inventory Saved Successfully"),
            ),
          );
          await addNewGarage(
              context, context.read<GarageProvider>().tempGarage!.images);
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
