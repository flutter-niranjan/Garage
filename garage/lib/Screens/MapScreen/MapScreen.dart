import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:garage/Model/garage.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:provider/provider.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});
  @override
  State createState() => _MapscreenState();
}

class _MapscreenState extends State {
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Marker? _searchedMarker;
  late GoogleMapController _mapController;
  LatLng _initialPosition = const LatLng(18.5204, 73.8567);
  final Set<Marker> _markers = {};
  String apiKey = "AIzaSyAhHAw59TVD60IlUcOUqtEXBmAz1yWyk6M";
  StreamSubscription<Position>? _positionStream;
  FlutterTts flutterTts = FlutterTts();
  List<dynamic> _routeSteps = [];
  int _currentStepIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _estimatedTime = '';
  List<dynamic> _searchSuggestions = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      LatLng current = LatLng(position.latitude, position.longitude);

      setState(() {
        _initialPosition = current;
      });
      _mapController.animateCamera(
        CameraUpdate.newLatLng(current),
      );

      _checkForNextStep(current);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _positionStream?.cancel();
    super.dispose();
  }

  void _checkForNextStep(LatLng current) {
    if (_currentStepIndex < _routeSteps.length) {
      final step = _routeSteps[_currentStepIndex];
      final LatLng stepLocation = LatLng(
        step["end_location"]["lat"],
        step["end_location"]["lng"],
      );

      double distance = Geolocator.distanceBetween(
        current.latitude,
        current.longitude,
        stepLocation.latitude,
        stepLocation.longitude,
      );

      if (distance < 30) {
        // threshold in meters
        _speak(step["html_instructions"].replaceAll(RegExp(r'<[^>]*>'), ''));
        _currentStepIndex++;
      }
    }
  }

  Future<void> _speak(String instruction) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(instruction);
  }

  Future<void> _drawRouteToMarker(LatLng destination,
      {String mode = "driving"}) async {
    try {
      // Get current user location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng origin = LatLng(position.latitude, position.longitude);

      // Helper to fetch route
      Future<Map<String, dynamic>?> fetchRoute(String mode) async {
        final String url =
            'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey&mode=$mode&alternatives=false&units=metric&steps=true';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data["routes"] != null && data["routes"].isNotEmpty) {
            return data;
          }
        }
        return null;
      }

      // Try requested mode first, then fallback to driving if needed
      Map<String, dynamic>? data = await fetchRoute(mode);
      String usedMode = mode;
      if (data == null && mode == "bicycling") {
        data = await fetchRoute("driving");
        usedMode = "driving";
      }

      if (data != null) {
        final encodedPoints = data["routes"][0]["overview_polyline"]["points"];
        List steps = data["routes"][0]["legs"][0]["steps"];
        String durationText = data["routes"][0]["legs"][0]["duration"]["text"];

        setState(() {
          _routeSteps = steps;
          _currentStepIndex = 0;
          _estimatedTime = durationText;
        });

        List<PointLatLng> result =
            PolylinePoints().decodePolyline(encodedPoints);

        if (result.isNotEmpty) {
          List<LatLng> polylineCoordinates = result
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          setState(() {
            _polylineCoordinates = polylineCoordinates;
            _polylines = {
              Polyline(
                polylineId: const PolylineId("route"),
                points: _polylineCoordinates,
                color: Colors.red,
                width: 5,
              ),
            };
          });

          // Animate camera to show both origin and destination
          LatLngBounds bounds = LatLngBounds(
            southwest: LatLng(
              origin.latitude < destination.latitude
                  ? origin.latitude
                  : destination.latitude,
              origin.longitude < destination.longitude
                  ? origin.longitude
                  : destination.longitude,
            ),
            northeast: LatLng(
              origin.latitude > destination.latitude
                  ? origin.latitude
                  : destination.latitude,
              origin.longitude > destination.longitude
                  ? origin.longitude
                  : destination.longitude,
            ),
          );

          _mapController.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 80),
          );
        }
      } else {
        print("No routes found");
        // Optionally show a dialog/snackbar to user
      }
    } catch (e) {
      print("Error drawing route: $e");
    }
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Location permission denied");
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
      ),
    );
    _fetchNearbyGarages();
  }

  Future<void> _fetchNearbyGarages({LatLng? location}) async {
    final LatLng searchLocation = location ?? _initialPosition;
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${searchLocation.latitude},${searchLocation.longitude}&radius=5000&type=car_repair&key=$apiKey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data["results"];
      Set<Marker> newMarkers = {};
      if (results.isNotEmpty) {
        for (var place in results) {
          final name = place["name"];
          final lat = place["geometry"]["location"]["lat"];
          final lng = place["geometry"]["location"]["lng"];
          final placeId = place["place_id"];
          newMarkers.add(Marker(
            markerId: MarkerId(name),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: name,
              onTap: () {
                _fetchGarageDetails(placeId, lat, lng);
              },
            ),
          ));
        }
        setState(() {
          // Remove all markers except the searched marker (if present)
          _markers.removeWhere((m) => m.markerId.value != "search_marker");
          _markers.addAll(newMarkers);
        });
        _cameraupdateToGarages();
      } else {
        print("No nearby garages Found");
      }
    } else {
      print("Error fetching nearby garages");
    }
  }

  Future<void> _fetchGarageDetails(
      String placeId, double lat, double lng) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,formatted_address,formatted_phone_number,opening_hours&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data["result"];

      String name = result["name"] ?? "No name";

      String address = result["formatted_address"] ?? "No address";
      String phone = result["formatted_phone_number"] ?? "No phone";
      List? hours = result["opening_hours"]?["weekday_text"];

      _showGarageDetails(name, address, phone, hours,lat,lng);
    } else {
      print("Failed to fetch place details");
    }
  }

  void _showGarageDetails(String name, String address, String phone,
      List? openHours, double lat, double lng) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(address, style: GoogleFonts.poppins(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Phone: $phone", style: GoogleFonts.poppins(fontSize: 16)),
            const SizedBox(height: 8),
            if (openHours != null) ...[
              Text("Opening Hours:",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ...openHours.map((line) => Text(line)).toList(),
            ],
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showTravelModeDialog(LatLng(lat, lng));
              },
              icon: const Icon(Icons.directions),
              label: Text(
                "Get Directions",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTravelModeDialog(LatLng destination) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Choose Travel Mode",
          style: GoogleFonts.poppins(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.directions_bike),
              label: Text(
                "Bike",
                style: GoogleFonts.poppins(),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await _showEstimatedTimeAndConfirm(destination, "bicycling");
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.directions_car),
              label: Text(
                "Car",
                style: GoogleFonts.poppins(),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await _showEstimatedTimeAndConfirm(destination, "driving");
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEstimatedTimeAndConfirm(
      LatLng destination, String mode) async {
    // Get current user location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng origin = LatLng(position.latitude, position.longitude);

    // Helper to fetch duration
    Future<String?> fetchDuration(String mode) async {
      final String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey&mode=$mode&alternatives=false&units=metric&steps=true';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["routes"] != null && data["routes"].isNotEmpty) {
          return data["routes"][0]["legs"][0]["duration"]["text"];
        }
      }
      return null;
    }

    String? durationText = await fetchDuration(mode);

    // If bike mode fails, fallback to driving for both time and route
    if ((durationText == null || durationText == "Unknown") &&
        mode == "bicycling") {
      durationText = await fetchDuration("driving");
      mode = "driving";
    }

    if (durationText == null) {
      durationText = "Not available";
    }

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Estimated Time",
          style: GoogleFonts.poppins(),
        ),
        content: Text(
          "Estimated time to reach: $durationText\nStart navigation?",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "Start",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _drawRouteToMarker(destination, mode: mode);
    }
  }

  Future<void> _searchLocation(String query) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(query)}&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        final latLng = LatLng(location['lat'], location['lng']);

        if (_searchedMarker != null) {
          _markers.remove(_searchedMarker);
        }

        _searchedMarker = Marker(
          markerId: const MarkerId("search_marker"),
          position: latLng,
          infoWindow: InfoWindow(title: query),
        );

        setState(() {
          _markers.clear(); // Clear all previous markers (including garages)
          _markers.add(_searchedMarker!);
        });

        _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));

        // Fetch nearby garages for the searched location
        await _fetchNearbyGarages(location: latLng);
      } else {
        print("No results found");
      }
    } else {
      print("Failed to fetch location");
    }
  }

  Future<void> _getSearchSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        _searchSuggestions = [];
      });
      return;
    }
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:in';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _searchSuggestions = data['predictions'];
      });
    } else {
      setState(() {
        _searchSuggestions = [];
      });
    }
  }

  void _cameraupdateToGarages() {
    if (_markers.isNotEmpty) {
      LatLngBounds bounds = _getBoundsFromMarkers();
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  LatLngBounds _getBoundsFromMarkers() {
    double minLat = _initialPosition.latitude;
    double minLng = _initialPosition.longitude;
    double maxLat = _initialPosition.latitude;
    double maxLng = _initialPosition.longitude;

    _markers.forEach((marker) {
      LatLng position = marker.position;
      if (position.latitude < minLat) minLat = position.latitude;
      if (position.latitude > maxLat) maxLat = position.latitude;
      if (position.longitude < minLng) minLng = position.longitude;
      if (position.longitude > maxLng) maxLng = position.longitude;
    });

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    final garageProvider = Provider.of<GarageProvider>(context);
    final garageMarker = garageProvider.garageMarkers.map((marker) {
      // Find the garage by markerId (name)
      final garage = garageProvider.garages.firstWhere(
  (g) => g.name == marker.markerId.value,
  orElse: () => Garage(
    id: DateTime.now().millisecondsSinceEpoch.toString(), // Provide a unique id
    name: marker.markerId.value,
    lat: marker.position.latitude,
    lng: marker.position.longitude,
    images: [],
    address: "No address",
    phone: "No phone",
    openingHours: [],
    categories: [],
    categoryItems: {}, // Provide an empty map
  ),
);
      return marker.copyWith(
        infoWindowParam: InfoWindow(
          title: garage.name,
          snippet: "Tap for details",
          onTap: () {
            _showGarageDetails(
              garage.name,
              garage.address,
              garage.phone,
              garage.openingHours,
              garage.lat,
              garage.lng
            );
          },
        ),
      );
    }).toSet();

    Set<Marker> combinedMarkers = {..._markers, ...garageMarker};
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 15,
            right: 15,
            child: _estimatedTime.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time, color: Colors.black87),
                        const SizedBox(width: 8),
                        Text(
                          "Estimated Time: $_estimatedTime",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 14),
            markers: combinedMarkers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
          ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _getSearchSuggestions(value);
              },
              onSubmitted: (value) {
                _searchLocation(value);
                setState(() {
                  _searchSuggestions = [];
                });
              },
              decoration: InputDecoration(
                  hintText: "Search Maps",
                  hintStyle: GoogleFonts.poppins(),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: _getUserLocation,
              child: Icon(Icons.my_location),
            ),
          ),
          if (_searchSuggestions.isNotEmpty)
            Positioned(
              top: 90,
              left: 15,
              right: 15,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _searchSuggestions[index];
                    return ListTile(
                      title: Text(
                        suggestion['description'],
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        _searchController.text = suggestion['description'];
                        _searchLocation(suggestion['description']);
                        setState(() {
                          _searchSuggestions = [];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
