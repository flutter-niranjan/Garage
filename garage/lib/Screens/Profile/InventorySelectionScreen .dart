import 'dart:io';
import 'package:flutter/material.dart';
import 'package:garage/Screens/Profile/PredefinedInventoryData.dart';
import 'package:image_picker/image_picker.dart'; 

class InventorySelectionScreen extends StatefulWidget {
  const InventorySelectionScreen({super.key});

  @override
  State<InventorySelectionScreen> createState() => _InventorySelectionScreenState();
}

class _InventorySelectionScreenState extends State<InventorySelectionScreen> {
  final Map<String, Set<String>> selectedItems = {};
  final List<Map<String, dynamic>> manuallyAddedItems = [];

  final ImagePicker _picker = ImagePicker();

  void _addManualItem() async {
    String? category;
    String? itemName;
    String? description;
    String? price;
    File? image;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return AlertDialog(
            title: const Text('Add Custom Inventory Item'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    items: predefinedInventory.keys
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    hint: const Text("Select Category"),
                    onChanged: (val) {
                      setModalState(() => category = val);
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Item Name'),
                    onChanged: (val) => itemName = val,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    onChanged: (val) => description = val,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => price = val,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
                      if (picked != null) {
                        setModalState(() => image = File(picked.path));
                      }
                    },
                    child: image != null
                        ? Image.file(image!, height: 100)
                        : Container(
                            color: Colors.grey[300],
                            height: 100,
                            width: double.infinity,
                            child: const Icon(Icons.add_a_photo),
                          ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (category != null && itemName != null) {
                    manuallyAddedItems.add({
                      'category': category!,
                      'item': itemName!,
                      'description': description ?? '',
                      'price': price ?? '',
                      'image': image,
                    });
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: const Text('Add'),
              )
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Garage Inventory')),
      body: ListView(
        children: [
          for (var category in predefinedInventory.keys)
            ExpansionTile(
              title: Text(category),
              children: [
                for (var item in predefinedInventory[category]!)
                  CheckboxListTile(
                    title: Text(item),
                    value: selectedItems[category]?.contains(item) ?? false,
                    onChanged: (val) {
                      setState(() {
                        selectedItems.putIfAbsent(category, () => <String>{});
                        if (val == true) {
                          selectedItems[category]!.add(item);
                        } else {
                          selectedItems[category]!.remove(item);
                        }
                      });
                    },
                  )
              ],
            ),
          if (manuallyAddedItems.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Custom Items", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                for (var custom in manuallyAddedItems)
                  ListTile(
                    leading: custom['image'] != null ? Image.file(custom['image'], width: 50) : null,
                    title: Text('${custom['category']} - ${custom['item']}'),
                    subtitle: Text('${custom['description']}  |  ₹${custom['price']}'),
                  ),
              ],
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'manual',
            onPressed: _addManualItem,
            tooltip: 'Add Custom Item',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'submit',
            onPressed: () {
              print('Selected: $selectedItems');
              print('Manual: $manuallyAddedItems');
              // Navigate to next step
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
