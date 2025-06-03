import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage/Model/cart_model.dart';
import 'package:garage/Model/garage.dart';
import 'package:garage/Screens/Home/item_screen.dart';
import 'package:garage/Screens/Inventory/inventory.dart';
import 'package:garage/Screens/CartScreen/my_cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GarageDetail extends StatefulWidget {
  final Garage garage;
  final PersistentTabController controller;
  const GarageDetail(
      {super.key, required this.garage, required this.controller});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.garage.images != null &&
                  widget.garage.images.isNotEmpty)
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
                                  child:
                                      const Icon(Icons.broken_image, size: 60),
                                ),
                              )
                            : Image.file(
                                File(imageUrl),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: Colors.grey[300],
                                  child:
                                      const Icon(Icons.broken_image, size: 60),
                                ),
                              ),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 10),
              if (widget.garage.images != null &&
                  widget.garage.images.isNotEmpty)
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
                      Clipboard.setData(
                          ClipboardData(text: widget.garage.phone));
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
                      final items = (widget
                                  .garage.categoryItems[category]?.values
                                  .toList() ??
                              [])
                          .map((item) => {
                                ...item,
                                "garageName": widget.garage
                                    .name, // Ensure garageName is present
                              })
                          .toList();
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
                        Text(category,
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ],
                    ),
                  );
                }).toList(),
              ),
              // ...existing code...
              const SizedBox(height: 10),
              Text("Servicing:", style: GoogleFonts.poppins(fontSize: 18)),
              const SizedBox(height: 10),
              // Remove the old single Container and add the three cards:
              servicePackageCard(
                garageName: widget.garage.name,
                context: context,
                title: "Basic Servicing",
                subtitle1: "➤ Every 5000 kms / 3 Months",
                subtitle2: "➤ Takes 4 hrs",
                subtitle3: "➤ 1 Month Warranty",
                subtitle4: "➤ free Pickup & Drop",
                imagePath: "assets/Service_Booking/Basic_Servicing.png",
                price: 17519.0,
                controller: widget.controller,
              ),
              servicePackageCard(
                context: context,
                garageName: widget.garage.name,
                title: "Standard Servicing",
                subtitle1: "➤ Every 10000 kms / 6 Months",
                subtitle2: "➤ Takes 6 hrs",
                subtitle3: "➤ 1 Month Warranty",
                subtitle4: "➤ free Pickup & Drop",
                imagePath: "assets/Service_Booking/Standard_Servicing.png",
                price: 21519.0,
                controller: widget.controller,
              ),
              servicePackageCard(
                context: context,
                garageName: widget.garage.name,

                title: "Comprehensive Servicing", // <-- fixed spelling
                subtitle1: "➤ Every 20000 kms / 12 Months",
                subtitle2: "➤ Takes 8 hrs",
                subtitle3: "➤ 1 Month Warranty",
                subtitle4: "➤ free Pickup & Drop",
                imagePath: "assets/Service_Booking/Comprehensive_Servicing.png",
                price: 28519.0,
                controller: widget.controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget servicePackageCard({
  required BuildContext context,
  required String garageName,
  required String title,
  required String subtitle1,
  required String subtitle2,
  required String subtitle3,
  required String subtitle4,
  required String imagePath,
  required double price,
  required PersistentTabController controller,
}) {
  return GestureDetector(
    onTap: () {
      // Provider.of<CartModel>(context, listen: false).addService(title, price);
      final cart = Provider.of<CartModel>(context, listen: false);
      // cart.setGarageName(garageName);
      cart.addService(
        title,
        price,
        imagePath,
        garageName: garageName,
        context: context,
      );
      if (cart.garageName == garageName) {
        controller.jumpToTab(2);
      }
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    subtitle1,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    subtitle2,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    subtitle3,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    subtitle4,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 204, 204, 204),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(imagePath),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
