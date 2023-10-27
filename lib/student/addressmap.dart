import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudentAddressMapPage extends StatefulWidget {
  @override
  _StudentAddressMapPageState createState() => _StudentAddressMapPageState();
}

class _StudentAddressMapPageState extends State<StudentAddressMapPage> {
  // ignore: unused_field
  GoogleMapController? _mapController;
  LatLng _selectedLocation = LatLng(26.4837, 87.2834);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapLongPress(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _returnDataAndPop() async{
     final List<Placemark> placemarks = await placemarkFromCoordinates(
    _selectedLocation.latitude,
    _selectedLocation.longitude,
  );

  String address = "Address not found"; 

  if (placemarks.isNotEmpty) {
    final Placemark placemark = placemarks[0];
                    if(placemark.subLocality!=null && placemark.subLocality!.trim().isNotEmpty){
                     address ='${placemark.subLocality}, ${placemark.locality}';
    print(_selectedLocation.latitude);
    print(_selectedLocation.longitude);

                    }else{
                    address = placemark.locality!;
                    }

    // address = "${placemark.street}, ${placemark.locality}, ${placemark.country}";
  }
    final selectedData = {
      'latitude': _selectedLocation.latitude,
      'longitude': _selectedLocation.longitude,
      'address': address, 
    };
    Navigator.pop(context, selectedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Locate Your Address on Map')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _selectedLocation, zoom: 15),
        markers: Set<Marker>.from([
          Marker(markerId: MarkerId('selected_location'), position: _selectedLocation),
        ]),
        onTap: _onMapLongPress,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _returnDataAndPop,
        child: Icon(Icons.check),
      ),
    );
  }
}