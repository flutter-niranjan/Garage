import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetail extends StatefulWidget {
  final Map<String, dynamic> item;
  const ItemDetail({super.key,required this.item});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item["name"] ?? "Item Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.item["image"] != null
                ? (widget.item["image"] is File
                    ? Image.file(
                        widget.item["image"],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(widget.item["image"].toString()),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ))
                : const Icon(Icons.image, size: 150),
            const SizedBox(height: 20),
            Text(
              widget.item["name"] ?? "No Name",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.item["description"] ?? "No Description",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: ${widget.item["price"] ?? "N/A"}",
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.red),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item added to cart!')),
                );
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
