import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Model/cart_model.dart';
import 'package:garage/Screens/Home/item_detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  final Map<int, int> _itemCounts = {};

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
          : ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final cart = Provider.of<CartModel>(context);
                final cartItem = cart.services.firstWhere(
                  (e) => e["name"] == item["name"],
                  orElse: () => {},
                );
                final count = cartItem.isNotEmpty && cartItem["count"] != null
                    ? cartItem["count"]
                    : 0;
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: item["image"] != null
                        ? (item["image"] is File
                            ? Image.file(
                                item["image"],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                item["image"].toString(),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ))
                        : const Icon(Icons.image, size: 50),
                    title: Text(
                      item["name"] ?? "No Name",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Price: ${item["price"] ?? "N/A"}",
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    trailing: count == 0
                        ? ElevatedButton(
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .addItem({
                                "name": item["name"],
                                "price": item["price"],
                                "imagePath": item["image"],
                                "count": 1,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('${item["name"]} added to cart')),
                              );
                            },
                            child: const Text("Add to Cart"),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (count > 1) {
                                    Provider.of<CartModel>(context,
                                            listen: false)
                                        .addItem({
                                      "name": item["name"],
                                      "price": item["price"],
                                      "imagePath": item["image"],
                                      "count": count - 1,
                                    });
                                  } else {
                                    Provider.of<CartModel>(context,
                                            listen: false)
                                        .removeService(item["name"]);
                                  }
                                },
                              ),
                              Text(
                                '$count',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .addItem({
                                    "name": item["name"],
                                    "price": item["price"],
                                    "imagePath": item["image"],
                                    "count": count + 1,
                                  });
                                },
                              ),
                            ],
                          ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetail(item: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
