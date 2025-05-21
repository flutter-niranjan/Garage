import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Screens/Home/home_screen.dart';
import 'package:garage/Screens/MapScreen/MapScreen.dart';
import 'package:garage/Screens/Profile/InventorySelectionScreen%20.dart';
import 'package:garage/Screens/Profile/add_inventory.dart';
import 'package:garage/Screens/Profile/profilescreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterPartner extends StatefulWidget {
  const RegisterPartner({super.key});
  @override
  State createState() => _RegisterPartnerState();
}

class _RegisterPartnerState extends State {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final List<String> _openingHours = List.filled(7, "");

  List<File> _images = [];
  List<String> _imagesURL = [];
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  Future<void> _updateMapLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _selectedLocation = LatLng(loc.latitude, loc.longitude);
        });
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_selectedLocation!, 15),
        );
      }
    } catch (e) {
      print("Geocoding failed: $e");
    }
  }

  // Map<String, bool> selectedInventory = {
  //   "Battery": false,
  //   "AC": false,
  //   "Tyres": false,
  //   "Brakes": false,
  //   "Clutch": false,
  //   "Steering": false,
  //   "Suspension": false,
  //   "Lights": false,
  //   "Seat Covers": false,
  //   "Glass": false,
  //   "Exhaust": false,
  //   "Side Mirror": false,
  //   "Bumper": false,
  //   "Spoiler": false,
  //   "Hood": false,
  //   "Hubcap": false,
  //   "Gear Box": false,
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register as Partner"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Garage Name",
                      ),
                      validator: (val) => val!.isEmpty ? "Enter name" : null,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(labelText: "Address"),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _updateMapLocation(value);
                        }
                      },
                      validator: (val) => val!.isEmpty ? "Enter address" : null,
                    ),
                    TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: "Phone"),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter phone number";
                          } else if (val.length != 10) {
                            return "Phone number must be 10 digits";
                          }
                          return null;
                        }),
                    // Add fields for opening hours (for each day)
                    for (int i = 0; i < 7; i++)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Opening Hours Day ${i + 1}",
                          hintText: "e.g. 09:00 am - 05:00 pm or 24 hrs open",
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        onChanged: (val) => _openingHours[i] = val,
                        validator: (val) => val == null || val.trim().isEmpty
                            ? "Enter opening hours"
                            : null,
                      ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _pickImages,
                      label: Text("Upload Images"),
                      icon: Icon(Icons.image),
                    ),
                    Wrap(
                      spacing: 8,
                      children: _images
                          .map((img) => Image.file(img, height: 80))
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(20.5937, 78.9629),
                          zoom: 5,
                        ),
                        markers: _selectedLocation != null
                            ? {
                                Marker(
                                  markerId: MarkerId("garageLocation"),
                                  position: _selectedLocation!,
                                ),
                              }
                            : {},
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Text("Select Inventory Provided:"),
                    // ...selectedInventory.keys.map((item) => CheckboxListTile(
                    //       title: Text(item),
                    //       value: selectedInventory[item],
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedInventory[item] = value ?? false;
                    //         });
                    //       },
                    //     )),
                    // SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedLocation != null &&
                            _images.isNotEmpty &&
                            _openingHours.every((h) => h.trim().isNotEmpty)) {
                          Provider.of<GarageProvider>(context, listen: false)
                              .addGarageMarkers(
                            _nameController.text.trim(),
                            _selectedLocation!.latitude,
                            _selectedLocation!.longitude,
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //       content: Text("Garage added Successfully!")),
                          // );
                          Provider.of<GarageProvider>(context, listen: false).addTempGarage(
                            _nameController.text.trim(),
                            _selectedLocation!.latitude,
                             _selectedLocation!.longitude,
                            _images,                                 //images to be add after storing to firebase storage
                            _addressController.text.trim(),
                            _phoneController.text.trim(),
                            _openingHours,
                          );
                          log("Garage added Temporarly!");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddInventory(
                                name: _nameController.text.trim(),
                                address: _addressController.text.trim(),
                                phone: _phoneController.text.trim(),
                                openingHours: _openingHours,
                                images: _images
                                    .map((f) => f.path)
                                    .toList(), // Use local images
                                lat: _selectedLocation!.latitude,
                                lng: _selectedLocation!.longitude,
                              ),
                            ),
                          );
                        } else {
                          String error = '';
                          if (_selectedLocation == null)
                            error = "Please select location on map.";
                          else if (_images.isEmpty)
                            error = "Please upload at least one image.";
                          else if (_openingHours.any((h) => h.trim().isEmpty))
                            error = "Please fill all opening hours.";
                          else
                            error = "Please fill all fields.";
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error)),
                          );
                        }
                      },
                      child: Text("Next Step"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
