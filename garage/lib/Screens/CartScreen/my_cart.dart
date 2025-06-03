import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Model/cart_model.dart';
import 'package:garage/Model/garage.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Providers/login_data.dart';
import 'package:garage/Screens/Home/garage_detail.dart';
import 'package:garage/Screens/Home/garagehomepage.dart';
import 'package:garage/Screens/Home/userhomepage.dart';
import 'package:garage/Screens/CartScreen/address_slot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:garage/Model/service_enum.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  final String garageName;
  final PersistentTabController controller;
  const MyCart({super.key, required this.garageName, required this.controller});

  @override
  State createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Service? _service = Service.pickup;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final garageName = cart.garageName ?? widget.garageName;

    final garageProvider = Provider.of<GarageProvider>(context, listen: false);
    final garage = garageProvider.garages.firstWhere(
      (g) => g.name.trim().toLowerCase() == garageName.trim().toLowerCase(),
      orElse: () => Garage(
        id: '',
        name: '',
        lat: 0,
        lng: 0,
        images: [],
        address: '',
        phone: '',
        openingHours: [],
        categories: [],
        categoryItems: {},
      ),
    );

    final loginData = Provider.of<LoginData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cart Items
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: cart.services.isEmpty
                    ? [
                        Center(
                          child: Text(
                            "Your cart is empty",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ]
                    : cart.services.map((service) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(92, 199, 199, 199),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: service["imagePath"] != null
                                      ? (service["imagePath"] is File
                                          ? Image.file(service["imagePath"],
                                              fit: BoxFit.cover)
                                          : Image.asset(
                                              service["imagePath"].toString(),
                                              fit: BoxFit.cover))
                                      : const Icon(Icons.image, size: 40),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service["name"] ?? "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Rs${service["price"] ?? ""}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Qty: ${service["count"] ?? 1}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cart.decrementItem(service["name"]);
                                },
                                icon: Icon(Icons.remove_circle_outline),
                                iconSize: 30,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  icon:
                      const Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: Text(
                    cart.services.isEmpty ? "Add Items" : "Add Other Items",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    final garageProvider =
                        Provider.of<GarageProvider>(context, listen: false);
                    if (cart.services.isEmpty) {
                      // Only switch to the Home tab
                      widget.controller.jumpToTab(0);
                      PersistentNavBarNavigator
                          .popUntilFirstScreenOnSelectedTabScreen(context);
                    } else {
                      Garage? garage;
                      try {
                        garage = garageProvider.garages.firstWhere(
                          (g) =>
                              g.name.trim().toLowerCase() ==
                              (cart.garageName ?? "").trim().toLowerCase(),
                        );
                      } catch (e) {
                        garage = null;
                      }
                      if (garage != null) {
                        widget.controller.jumpToTab(0);
                        PersistentNavBarNavigator
                            .popUntilFirstScreenOnSelectedTabScreen(context);
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => GarageDetail(
                        //       garage: garage!,
                        //       controller: widget.controller,
                        //     ),
                        //   ),
                        // );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("garage not found")),
                        );
                      }
                    }
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(92, 199, 199, 199),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 15),
                      child: Text(
                        "Mode of Service",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Radio<Service>(
                          value: Service.pickup,
                          groupValue: _service,
                          onChanged: (Service? value) {
                            setState(() {
                              _service = value;
                            });
                          },
                        ),
                        Text("Pick-up"),
                        SizedBox(width: 20),
                        Radio<Service>(
                          value: Service.walkin,
                          groupValue: _service,
                          onChanged: (Service? value) {
                            setState(() {
                              _service = value;
                            });
                          },
                        ),
                        Text("Walk-in"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bill Section
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bill",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (cart.services.isNotEmpty)
                        Text(
                          "Garage: $garageName",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                      if (cart.services.isNotEmpty && garage != null)
                        Text(
                          "Garage Number: ${garage.phone}",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                      if (cart.services.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Name: ${loginData.name}",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              "Mobile: ${loginData.mobile}",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              "Email: ${loginData.email}",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      if (cart.services.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cart.services.map<Widget>((service) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${service["name"]} x${service["count"] ?? 1}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Rs. ${service["price"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      if (cart.services.isNotEmpty)
                        totalBill("Warranty Fee", "Rs. 99"),
                      const Divider(),
                      totalBill(
                        "Grand Total",
                        cart.services.isNotEmpty
                            ? "Rs. ${cart.totalAmount + 99}"
                            : "Rs. ${cart.totalAmount}",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 90),
          ],
        ),
      ),

      // FAB to proceed
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (_service != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressSlot(
                      serviceMode: _service!), // Assuming this is correct
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please select a service mode")),
              );
            }
          },
          child: Text(
            "Select Address And Slot",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget totalBill(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
