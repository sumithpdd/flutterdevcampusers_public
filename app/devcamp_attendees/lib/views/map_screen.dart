// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/dev_camp_user.dart';

class MapScreen extends StatefulWidget {
  List<DevCampUser> listUsers;
  MapScreen({
    Key? key,
    required this.listUsers,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(51.509865, -0.118092);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 100)),
            "assets/Flutter_Devcamp-logos_black.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialLocation,
            zoom: 14,
          ),
          markers: _getMarkers(widget.listUsers)),
    );
  }

  Set<Marker> _getMarkers(List<DevCampUser> users) {
    List<Marker> markers = [];

    for (DevCampUser devcampuser in users) {
      markers.add(
        Marker(
          markerId: MarkerId("Marker ${devcampuser.id}"),
          position: LatLng(double.parse(devcampuser.address!.geo!.lat!),
              double.parse(devcampuser.address!.geo!.lng!)),
          draggable: false,
          infoWindow: InfoWindow(title: devcampuser.name, snippet: '*'),
          onDragEnd: (value) {
            // value is the new position
          },
          icon: markerIcon,
        ),
      );
    }
    return Set.of(markers.toList());
  }
}
