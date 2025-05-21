import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage/Model/garage.dart';
import 'package:garage/Screens/Home/item_screen.dart';
import 'package:garage/Screens/Inventory/inventory.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GarageDetail extends StatefulWidget {
  final Garage garage;

  const GarageDetail({super.key, required this.garage});

  @override
  State<GarageDetail> createState() => _GarageDetailState();
}

class _GarageDetailState extends State<GarageDetail> {
  final Map<String, String> categoryIcons = {
    'AC': "assets/Inventory/AC.png",
    'Battery': "assets/Inventory/Battery.png",
    'Brake': "assets/Inventory/Brake.png",
    'Clutch': "assets/Inventory/Clutch.png",
    'Glass': "assets/Inventory/Glass.png",
    'Lights': "assets/Inventory/Lights.png",
    'Suspension': "assets/Inventory/Suspension.png",
    'Tyres': "assets/Inventory/Tyre.png",
  };
  int _currentImageIndex = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.garage.name.toUpperCase(),
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.garage.images != null && widget.garage.images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.7,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: widget.garage.images.map((imageUrl) {
                    final isNetwork = imageUrl.startsWith('http');
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: isNetwork
                          ? Image.network(
                              imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 60),
                              ),
                            )
                          : Image.file(
                              File(imageUrl),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 60),
                              ),
                            ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 10),
            if (widget.garage.images != null && widget.garage.images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedSmoothIndicator(
                        activeIndex: _currentImageIndex,
                        count: widget.garage.images.length,
                        effect: const JumpingDotEffect(
                          dotColor: Colors.black,
                          dotHeight: 15,
                          dotWidth: 15,
                          activeDotColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Garage Name: ",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[800], // Label color
                    ),
                  ),
                  TextSpan(
                    text: widget.garage.name.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.red, // Name color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
// ...existing code...
            const SizedBox(
              height: 10,
            ),
            // ...existing code...
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Garage Address: ",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[800], // Label color
                    ),
                  ),
                  TextSpan(
                    text: widget.garage.address,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.red, // Name color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
// ...existing code...
            const SizedBox(
              height: 10,
            ),
            // ...existing code...
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Garage Number: ",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey[800], // Label color
                        ),
                      ),
                      TextSpan(
                        text: widget.garage.phone,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.red, // Name color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.garage.phone));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Phone number copied to clipboard')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            // Text("Rating: ${widget.garage['rating']}",style: GoogleFonts.poppins(fontSize: 18),),
            Text("Categories:", style: GoogleFonts.poppins(fontSize: 18)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: widget.garage.categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    final items = widget.garage.categoryItems[category]?.values
                            .toList() ??
                        [];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemScreen(
                          category: category,
                          items: items,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue[100],
                        child: categoryIcons.containsKey(category)
                            ? Image.asset(
                                categoryIcons[category]!,
                                width: 30,
                                height: 30,
                              )
                            : Icon(
                                Icons.category,
                                size: 30,
                                color: Colors.blue[800],
                              ),
                      ),
                      const SizedBox(height: 5),
                      Text(category, style: GoogleFonts.poppins(fontSize: 14)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
