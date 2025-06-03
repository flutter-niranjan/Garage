import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Model/cart_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatefulWidget {
  final Map<String, dynamic> item;
  const ItemDetail({super.key, required this.item});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  bool _updateCart(BuildContext context, int count) {
    if (count > 0) {
      return Provider.of<CartModel>(context, listen: false).addItem({
        "name": widget.item["name"],
        "price": widget.item["price"],
        "imagePath": widget.item["image"],
        "count": count,
        "garageName": widget.item["garageName"],
      }, garageName: widget.item["garageName"], context: context);
    } else {
      Provider.of<CartModel>(context, listen: false)
          .removeService(widget.item["name"]);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final cartItem = cart.services.firstWhere(
      (e) => e["name"] == widget.item["name"],
      orElse: () => {},
    );
    final count = cartItem.isNotEmpty && cartItem["count"] != null
        ? cartItem["count"]
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item["name"] ?? "Item Detail"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.item["image"] != null
                  ? (widget.item["image"] is File
                      ? Image.file(
                          widget.item["image"],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.item["image"].toString(),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ))
                  : const Icon(Icons.image, size: 150),
              const SizedBox(height: 20),
              Text(
                widget.item["name"] ?? "No Name",
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold),
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
              count == 0
                  ? ElevatedButton(
                      onPressed: () {
                        final added = _updateCart(context, 1);
                        if (added) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Item added to cart!')));
                        }
                      },
                      child: const Text("Add to Cart"),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            if (count > 1) {
                              _updateCart(context, count - 1);
                            } else if (count == 1) {
                              _updateCart(context, 0);
                            }
                          },
                        ),
                        Text(
                          '$count',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            _updateCart(context, count + 1);
                          },
                        ),
                      ],
                    ),
              if (count == 0) const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
