import 'package:flutter/material.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Screens/Profile/item_description.dart';
import 'package:provider/provider.dart';

class SpecificItem extends StatefulWidget {
  final List<String> selectedCategories;
  final String garageId;
  const SpecificItem(
      {super.key, required this.selectedCategories, required this.garageId});

  @override
  State<SpecificItem> createState() => _SpecificItemState();
}

class _SpecificItemState extends State<SpecificItem> {
  final Map<String, List<String>> itemOption = {
    'Battery': ["Acdelco", "Amaron", "Bosch", 'Exide', 'Luminous'],
    'AC': [
      'AC Cooling Coil',
      'Compressor',
      'Condenser',
      "Heating Coil",
      "V Belt"
    ],
    "Glass": [
      "Back Window",
      "Front Door Glass",
      "Rear Door Glass",
      "Rear Quater",
      "Vent",
      "Windshield"
    ],
    'Brake': ['Disk Brakes', 'Front Brake Pads', "Rear Brake Pads"],
    "Lights": ["Foglight", "Headlight", "Taillight"],
    "Suspension": [
      "Front Axle",
      "Front Shock Absorber",
      "Link Rod",
      "Rear Shock Absorber",
      "Tie Rod"
    ],
    "Tyres": ["Apollo", "Ceat", "Jktyres", "MRF"],
    "Clutch": ["Clutch Overhaul"]
  };

  final Map<String, Set<String>> selectedItem = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.selectedCategories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Item"),
          bottom: TabBar(
            isScrollable: true,
            tabs:
                widget.selectedCategories.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        body: TabBarView(
          children: widget.selectedCategories.map((category) {
            final items = itemOption[category] ?? [];
            selectedItem[category] = selectedItem[category] ?? {};

            return StatefulBuilder(
              builder: (context, tabSetState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: items.map((item) {
                          final isSelected =
                              selectedItem[category]!.contains(item);
                          return CheckboxListTile(
                            title: Text(item),
                            value: isSelected,
                            onChanged: (bool? value) {
                              tabSetState(() {
                                if (value == true) {
                                  selectedItem[category]!.add(item);
                                } else {
                                  selectedItem[category]!.remove(item);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Add Item Manually"),
                        onPressed: () {
                          _showManualEntryDialog(
                              context, category, tabSetState);
                        },
                      ),
                    )
                  ],
                );
              },
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            print(selectedItem);
            Provider.of<GarageProvider>(context, listen: false)
                .addCategoryItemsToGarage(
              widget.garageId,
              selectedItem.map((category, items) => MapEntry(
                    category,
                    {
                      for (var item in items)
                        item: {
                          // "description": item,
                          "name": item,
                          // Optionally add: "price": "", "image": null
                        }
                    },
                  )),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDescription(
                  selectedItem: selectedItem,
                  garageId: widget.garageId, // <-- Pass the garageId here
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showManualEntryDialog(
      BuildContext context, String category, StateSetter tabSetState) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Custom Item"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Enter item name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newItem = controller.text.trim();
                if (newItem.isNotEmpty) {
                  setState(() {
                    itemOption[category]!.add(newItem);
                    selectedItem[category]!.add(newItem);
                  });
                  tabSetState(() {}); // Refresh the checkbox list
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
