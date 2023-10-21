import 'package:favorite_place/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.isSelected = true,
      this.location = const PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
        address: '',
      )});

  final PlaceLocation location;
  final bool isSelected;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelected ? 'Pick your location' : 'Your location'),
        actions: [
          if (widget.isSelected)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelected ? null: (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelected)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                          widget.location.latitude, widget.location.longitude),
                )
              },
      ),
    );
  }
}


/*

position: _pickedLocation != null
    ? _pickedLocation!
    : LatLng(widget.location.latitude, widget.location.longitude)

position: _pickedLocation ?? LatLng(widget.location.latitude, widget.location.longitude),
(it is the short version of the above A?c:d code if c is null d will be used else c will be used)


 */
