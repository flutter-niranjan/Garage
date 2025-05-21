import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:garage/Screens/Inventory/acPage.dart';
import 'package:garage/Screens/Inventory/add_item.dart';
import 'package:garage/Screens/Inventory/batteryPage.dart';
import 'package:garage/Screens/Inventory/brakePage.dart';
import 'package:garage/Screens/Inventory/bumperPage.dart';
import 'package:garage/Screens/Inventory/clutchPage.dart';
import 'package:garage/Screens/Inventory/exhaustPage.dart';
import 'package:garage/Screens/Inventory/gearBoxPage.dart';
import 'package:garage/Screens/Inventory/glassPage.dart';
import 'package:garage/Screens/Inventory/hoodPage.dart';
import 'package:garage/Screens/Inventory/hubcapPage.dart';
import 'package:garage/Screens/Inventory/lightPage.dart';
import 'package:garage/Screens/Inventory/seatCoverPage.dart';
import 'package:garage/Screens/Inventory/sideMirrorPage.dart';
import 'package:garage/Screens/Inventory/spoilerPage.dart';
import 'package:garage/Screens/Inventory/steeringPage.dart';
import 'package:garage/Screens/Inventory/suspensionPage.dart';
import 'package:garage/Screens/Inventory/tyrePage.dart';
import 'package:google_fonts/google_fonts.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State createState() => _InventoryState();
}

class _InventoryState extends State {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> inventoryItems = [
    {"name": "Battery", "image": "assets/Inventory/Battery.png"},
    {"name": "AC", "image": "assets/Inventory/AC.png"},
    {"name": "Tyres", "image": "assets/Inventory/Tyre.png"},
    {"name": "Brakes", "image": "assets/Inventory/Brake.png"},
    {"name": "Clutch", "image": "assets/Inventory/Clutch.png"},
    {"name": "Steering", "image": "assets/Inventory/Stearing.png"},
    {"name": "Suspension", "image": "assets/Inventory/Suspension.png"},
    {"name": "Lights", "image": "assets/Inventory/Lights.png"},
    {"name": "Seat Covers", "image": "assets/Inventory/Covers.png"},
    {"name": "Glass", "image": "assets/Inventory/Glass.png"},
    {"name": "Exhaust", "image": "assets/Inventory/Exhaust.png"},
    {"name": "Side Mirror", "image": "assets/Inventory/Mirror.png"},
    {"name": "Bumper", "image": "assets/Inventory/Bumper.png"},
    {"name": "Spoiler", "image": "assets/Inventory/Spoiler.png"},
    {"name": "Hood", "image": "assets/Inventory/Hood.png"},
    {"name": "Hubcap", "image": "assets/Inventory/Hubcap.png"},
    {"name": "Gear Box", "image": "assets/Inventory/Gear.png"},
    {"name": "Add Item", "image": "assets/Inventory/AddItem.png"},
  ];
  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = inventoryItems;
    _controller.addListener(() {
      filterItems();
    });
  }

  void filterItems() {
    final query = _controller.text.toLowerCase();
    setState(() {
      filteredItems = inventoryItems
          .where((items) => items["name"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToPage(String pageName) {
    late Widget page;
    switch (pageName) {
      case "Battery":
        page = BatteryPage();
        break;
      case "AC":
        page = AcPage();
        break;
      case "Tyres":
        page = TyrePage();
        break;
      case "Brakes":
        page = BrakePage();
        break;
      case "Clutch":
        page = ClutchPage();
        break;
      case "Steering":
        page = SteeringPage();
        break;
      case "Suspension":
        page = SuspensionPage();
        break;
      case "Lights":
        page = LightPage();
        break;
      case "Seat Covers":
        page = SeatCoverPage();
        break;
      case "Glass":
        page = GlassPage();
        break;
      case "Exhaust":
        page = ExhaustPage();
        break;
      case "Side Mirror":
        page = SideMirrorPage();
        break;
      case "Bumper":
        page = BumperPage();
        break;
      case "Spoiler":
        page = SpoilerPage();
      case "Hood":
        page = HoodPage();
        break;
      case "Hubcap":
        page = HubcapPage();
        break;
      case "Gear Box":
        page = GearBoxPage();
        break;
      case "Add Item":
        page = AddItem();
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: GoogleFonts.poppins(),
                  prefix: const Icon(Icons.search),
                  filled: true,
                  // fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 130, left: 20, right: 20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => navigateToPage(filteredItems[index]["name"]!),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("${filteredItems[index]["image"]}"),
                      const SizedBox(height: 5),
                      Text(
                        filteredItems[index]["name"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
