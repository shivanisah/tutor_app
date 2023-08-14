import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudentUpdateAddressMapPage extends StatefulWidget {
  final Map<String,dynamic> initialLocation;
  StudentUpdateAddressMapPage(this.initialLocation);

  @override
  _StudentUpdateAddressMapPageState createState() => _StudentUpdateAddressMapPageState();
}

class _StudentUpdateAddressMapPageState extends State<StudentUpdateAddressMapPage> {
  // ignore: unused_field
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;

  @override

  void initState(){
    super.initState();
    double initialLatitude = widget.initialLocation['latitude']?? 26.4837;
    double initialLongitude = widget.initialLocation['longitude']?? 87.2834;
    _selectedLocation = LatLng(initialLatitude, initialLongitude);
  }
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
    _selectedLocation!.latitude,
    _selectedLocation!.longitude,
  );

  String address = "Address not found"; 

  if (placemarks.isNotEmpty) {
    final Placemark placemark = placemarks[0];
                    if(placemark.subLocality!=null && placemark.subLocality!.trim().isNotEmpty){
                     address ='${placemark.subLocality}, ${placemark.locality}';

                    }else{
                    address = placemark.locality!;
                    }

    // address = "${placemark.street}, ${placemark.locality}, ${placemark.country}";
  }
    
    final selectedData = {
      'latitude': _selectedLocation!.latitude,
      'longitude': _selectedLocation!.longitude,
      'address': address, 
    };
    Navigator.pop(context, selectedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Page')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _selectedLocation?? LatLng(26.4837, 87.2834), zoom: 15),
        markers: Set<Marker>.from([
          Marker(markerId: const MarkerId('selected_location'), position: _selectedLocation?? LatLng(26.4837, 87.2834)),
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