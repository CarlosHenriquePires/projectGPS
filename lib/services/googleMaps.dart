import 'dart:async';
import 'package:cloudwalktest3/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _latLng = LatLng(0,0);
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void moveMapToPosition(CameraPosition position) {
      _latLng = position.target;
  }

  getPosition() async {
    Position position = await Geolocation().getLocation();
    print(position);
    setState(() {
      _latLng = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
        markerId: MarkerId("I'm Here!"),
        position: _latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: null,
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _latLng,
            zoom: 11.0,
          ),
          markers: _markers,
          onCameraMove: moveMapToPosition,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getPosition,
        label: Text('My Position'),
        icon: Icon(Icons.person_pin_circle),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop
    );
  }
}
