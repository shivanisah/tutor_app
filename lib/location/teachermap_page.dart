import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TeacherMapPage extends StatefulWidget {
  @override
  _TeacherMapPageState createState() => _TeacherMapPageState();
}

class _TeacherMapPageState extends State<TeacherMapPage> {
  List<Map<String, dynamic>> teachers = [];
  Set<Marker> markers = {};
  Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  Future<void> getCurrentLocationAndFindTeachers() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, handle this case
      return;
    }

    // Check for permission to access the location
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Location permission is permanently denied, handle this case
      return;
    }
    if (permission == LocationPermission.denied) {
      // Location permission is denied, request it
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Location permission is denied, handle this case
        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Make a POST request to the Django view
    var url = Uri.parse('http://192.168.1.81:8000/find_teachers/');
    var response = await http.post(
      url,
      body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        teachers = List<Map<String, dynamic>>.from(data['teachers']);
        markers = _createMarkers(teachers);
      });

      // Animate the marker motion
      if (_mapController.isCompleted) {
        GoogleMapController controller = await _mapController.future;
        markers.forEach((marker) async {
          LatLng target = marker.position;
          controller.animateCamera(CameraUpdate.newLatLng(target));
          await Future.delayed(Duration(seconds: 1)); // Adjust the delay as per your preference
        });
      }
    } else {
      // Handle the error response...
    }
  }

  Set<Marker> _createMarkers(List<Map<String, dynamic>> teachers) {
    Set<Marker> markers = {};
    teachers.forEach((teacher) {
      String name = teacher['name'];
      double latitude = double.parse(teacher['latitude']);
      double longitude = double.parse(teacher['longitude']);

      Marker marker = Marker(
        markerId: MarkerId(name),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      markers.add(marker);
    });
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(27.7172, 85.3240),                        
                  zoom: 12,             
              ),
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              // Other map configuration options...
            ),
          ),
          ElevatedButton(
            onPressed: getCurrentLocationAndFindTeachers,
            child: Text('Find Teachers'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                String name = teachers[index]['name'];
                double latitude = double.parse(teachers[index]['latitude']);
                double longitude = double.parse(teachers[index]['longitude']);

                return Card(
                  child: ListTile(
                    title: Text(name),
                    subtitle: Text('Latitude: $latitude, Longitude: $longitude'),
                    // Other card content...
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
