import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? mapController;
  LocationData? _currentLocation;
  String _address = "Fetching address...";

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default San Francisco position
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch the user's current location at startup
  }

  Future<void> _getCurrentLocation() async {
    try {
      Location location = Location();

      if (!await location.serviceEnabled()) {
        if (!await location.requestService()) return;
      }

      if (await location.hasPermission() == PermissionStatus.denied) {
        if (await location.requestPermission() != PermissionStatus.granted) {
          return;
        }
      }

      final locData = await location.getLocation();
      setState(() {
        _currentLocation = locData;
      });

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(locData.latitude!, locData.longitude!),
          ),
        );
      }

      await _fetchAddress(locData.latitude!, locData.longitude!);
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  Future<void> _fetchAddress(double latitude, double longitude) async {
    final apiKey =
        'AIzaSyDST1RamxpF9Ql_znBxRbzZpZnzoR2g6i4'; // Replace with your real API key
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _address = data['results'].isNotEmpty
            ? data['results'][0]['formatted_address']
            : 'No address found.';
      });
    } else {
      setState(() {
        _address = 'Failed to fetch address.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:
          true, // Ensures body content extends behind BottomNavigationBar
      extendBodyBehindAppBar:
          true, // Ensures body content extends behind the AppBar
      body: Stack(
        children: [
          // Full-screen Google Map
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: (controller) async {
                mapController = controller;
                if (_currentLocation == null) {
                  await _getCurrentLocation();
                } else {
                  mapController!.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                      ),
                    ),
                  );
                }
              },
              myLocationEnabled: true, // Enable "My Location" button
              myLocationButtonEnabled: true, // Show the "My Location" button
            ),
          ),
          // Address Text Overlay
          // Positioned(
          //   top: 80, // Adjust to avoid overlapping with AppBar
          //   left: 10,
          //   right: 10,
          //   child: Container(
          //     padding: const EdgeInsets.all(8.0),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(12.0),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.1),
          //           blurRadius: 10.0,
          //           spreadRadius: 5.0,
          //         ),
          //       ],
          //     ),
          //     child: Text(
          //       _address,
          //       style: const TextStyle(fontSize: 16.0),
          //     ),
          //   ),
          // ),
          // Location Cards Overlay at the Bottom
          Positioned(
            bottom: 70.0, // Leave space above BottomNavigationBar
            left: 10.0,
            right: 10.0,
            child: _buildLocationList(),
          ),
        ],
      ),
    );
  }

  // Widget to build location list
  Widget _buildLocationList() {
    return SizedBox(
      height: 180.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _locationCard('Tech Gate HQ', 'Main office in downtown'),
          _locationCard('Tech Gate West', 'Our branch in the west district'),
          _locationCard('Tech Gate East', 'Eastern branch for support'),
        ],
      ),
    );
  }

  // Widget to build each location card
  Widget _locationCard(String title, String subtitle) {
    return Container(
      width: 230.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 182, 27, 27).withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to detailed location view or perform an action
                },
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
