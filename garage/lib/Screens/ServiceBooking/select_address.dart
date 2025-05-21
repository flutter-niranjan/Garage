import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});
  @override
  State createState() => _SelectAddressState();
}

class _SelectAddressState extends State {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;
  String _mainAddress = 'Tap on the map to select location';
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  Future<void> _setCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          "Location permission denied",
          style: GoogleFonts.poppins(),
        )),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _selectedLatLng = LatLng(position.latitude, position.longitude);
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _selectedLatLng!, zoom: 16),
      ),
    );

    _getAddressFromLatLng(_selectedLatLng!);
  }

  void _getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      setState(() {
        _mainAddress =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
      });
    }
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLatLng = position;
      _mainAddress = 'Loading address...';
    });
    _getAddressFromLatLng(position);
  }

  void _confirmLocation() {
    final fullAddress = '''
$_mainAddress
Building: ${_buildingController.text}
Landmark: ${_landmarkController.text}
Note: ${_noteController.text}
''';
    Navigator.pop(context, fullAddress.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Select Location',
        style: GoogleFonts.poppins(),
      )),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(18.5204, 73.8567), // fallback to Pune
              zoom: 14.0,
            ),
            onTap: _onMapTap,
            markers: _selectedLatLng != null
                ? {
                    Marker(
                      markerId: MarkerId('selected'),
                      position: _selectedLatLng!,
                    )
                  }
                : {},
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.6,
            builder: (context, scrollController) => Container(
              color: Colors.white,
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Address:",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Text(_mainAddress,
                        style: GoogleFonts.poppins(color: Colors.black)),
                    SizedBox(height: 10),
                    TextField(
                      controller: _buildingController,
                      decoration: InputDecoration(
                        labelText: "Building Name / Flat No.",
                        labelStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _landmarkController,
                      decoration: InputDecoration(
                        labelText: "Landmark",
                        labelStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        labelText: "Additional Note (Optional)",
                        labelStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed:
                            _selectedLatLng != null ? _confirmLocation : null,
                        child: Text(
                          "Confirm Location",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
