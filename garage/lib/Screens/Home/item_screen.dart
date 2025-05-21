import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Screens/Home/item_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemScreen extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> items;
  const ItemScreen({
    super.key,
    required this.category,
    required this.items,
  });

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} Items"),
      ),
      body: widget.items.isEmpty
          ? const Center(
              child: Text("No items available in this category"),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemDetail(
                                  item: item,
                                )));
                  },
                  child: Column(
                    children: [
                      item["image"] != null
                          ? (item["image"] is File
                              ? Image.file(
                                  item["image"],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(item["image"].toString()),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ))
                          : const Icon(Icons.image, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        item["name"] ?? "No Name",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Price: ${item["price"] ?? "N/A"}",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ],
                  ),
                );
                // return ListTile(
                //   leading: item["image"] != null
                //       ? (item["image"] is File
                //           ? Image.file(
                //               item["image"],
                //               width: 50,
                //               height: 50,
                //               fit: BoxFit.cover,
                //             )
                //           : Image.file(
                //               File(item["image"].toString()),
                //               width: 50,
                //               height: 50,
                //               fit: BoxFit.cover,
                //             ))
                //       : const Icon(Icons.image),
                //   title: Text(item["description"] ?? "No Description"),
                //   subtitle: Text("Price: ${item["price"] ?? "N/A"}"),
                //   onTap: () {},
                // );
              },
            ),
    );
  }
}
