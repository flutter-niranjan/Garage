import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NewMap extends StatefulWidget {
  const NewMap({super.key});
  @override
  State<StatefulWidget> createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  bool _trafficEnabled = false;
  LatLng? _currentLocation;
  Set<Marker> _garageMarkers = {};

  void _addTestGarageMarkers() {
    Set<Marker> testMarkers = {
      Marker(
        markerId: MarkerId('garage1'),
        position: LatLng(18.5204, 73.8567), // Pune
        infoWindow: InfoWindow(title: 'Sharma Auto Garage'),
      ),
      Marker(
        markerId: MarkerId('garage2'),
        position: LatLng(18.5215, 73.8548),
        infoWindow: InfoWindow(title: 'Speedy Wheels Workshop'),
      ),
      Marker(
        markerId: MarkerId('garage3'),
        position: LatLng(18.5193, 73.8587),
        infoWindow: InfoWindow(title: 'Elite Auto Care'),
      ),
    };

    setState(() {
      _garageMarkers = testMarkers;
    });
  }

  Future<void> _fetchNearbyGarages() async {
    final apiKey = 'AIzaSyAhHAw59TVD60IlUcOUqtEXBmAz1yWyk6M';
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${_currentLocation!.latitude},${_currentLocation!.longitude}'
        '&radius=5000'
        '&type=car_repair'
        '&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (_currentLocation == null) {
      print("Current location is null, skipping garage fetch.");
      return;
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      Set<Marker> markers = {};
      for (var place in results) {
        final name = place['name'];
        final lat = place['geometry']['location']['lat'];
        final lng = place['geometry']['location']['lng'];

        markers.add(Marker(
          markerId: MarkerId(name),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: name),
        ));
      }

      setState(() {
        _garageMarkers = markers;
      });
    } else {
      print("Failed to load nearby garages: ${response.body}");
    }
    print("Nearby garages response: ${response.body}");
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enable location services")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final location = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLocation = location;
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 14),
      ),
    );

    await _fetchNearbyGarages();
    _addTestGarageMarkers();
  }

  Future<void> _openDirections(LatLng destination) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}&travelmode=driving';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _toggleTraffic() {
    setState(() {
      _trafficEnabled = !_trafficEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Garages"),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            tooltip: "Toggle Map Type",
            onPressed: _toggleMapType,
          ),
          IconButton(
            icon: Icon(Icons.traffic),
            tooltip: "Toggle Traffic",
            onPressed: _toggleTraffic,
          ),
        ],
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  mapType: _currentMapType,
                  trafficEnabled: _trafficEnabled,
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _garageMarkers,
                ),
                Positioned(
                  top: 10,
                  left: 15,
                  right: 15,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        // TODO: Integrate Google Places Search
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Search feature coming soon")),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: "Search garages...",
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
