import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class MapWidget extends StatefulWidget {

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng initialcameraposition = LatLng(13.716183, 100.3445043);
  GoogleMapController controller;
  Location location = Location();
  LocationData currentLocation;
  void initState() {
    super.initState();
    findLocation();
  }
  Future<void> findLocation() async {
    currentLocation = await locationData();
    //print('lat = ${currentLocation.latitude}, lng = ${currentLocation.longitude}');
  }
  Future<LocationData> locationData() async {
    var location = Location();
    try {
      return await location.getLocation();
    } catch (e) {}
    return null;
  }
  void onMapCreated(GoogleMapController cntlr) {
    controller = cntlr;
    location.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 20),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return
      Container(
        height: screenHeight * .5,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: GoogleMap(
            initialCameraPosition:
            CameraPosition(target: initialcameraposition),
            mapType: MapType.normal,
            onMapCreated: onMapCreated,
            myLocationEnabled: true,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      )
    ;
  }
}