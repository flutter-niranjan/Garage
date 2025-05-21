import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Screens/Home/garage_detail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  var data1;
  bool _isLoading = true;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getGarages();
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {});
    } catch (e) {
      log("Error getting location: $e");
    }
  }

  Future<void> getGarages() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Garages').get();
      data1 = data.docs;
      print(data1);
    } catch (e) {
      log("error while retrieving data");
    } finally {
      setState(() {
        _isLoading = false;
      });
      log("no loading");
    }

    log("data display");
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  @override
  Widget build(BuildContext context) {
    final garageProvider = Provider.of<GarageProvider>(context);
    final garages = garageProvider.garages;

    if (_currentPosition != null) {
      garages.sort((a, b) {
        final distA = _calculateDistance(_currentPosition!.latitude,
            _currentPosition!.longitude, a.lat, a.lng);
        final distB = _calculateDistance(_currentPosition!.latitude,
            _currentPosition!.longitude, b.lat, b.lng);
        return distA.compareTo(distB);
      });
    }

    return _isLoading
        ? const Center(child: Text("Loading"))
        : Scaffold(
            appBar: AppBar(
              // title: Text("Garages"),
              title: const Text('Garages'),
            ),
            body: ListView.builder(
              itemCount: garages.length,
              itemBuilder: (context, index) {
                final garage = garages[index];
                // final garage = data1[index].data();
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GarageDetail(garage: garage),
                      ),
                    );
                  },
                  title: Text(
                    garage.name.toUpperCase(),
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(garage.address),
                  leading: garage.images.isNotEmpty
                      ? (garage.images[0].startsWith('http')
                          ? Image.network(
                              garage.images[0],
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(garage.images[0]),
                              width: 60,
                              fit: BoxFit.cover,
                            ))
                      : const Icon(Icons.garage),
                );
              },
            ),
          );
  }
}
