import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_project/Screens/NewMap.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Position position;
  double latitude;
  double longitude;
  var addresses;
  var first;

  double distanceInMeters;
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController _controller;

  Future getcurrentlocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: latitude != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Stack(
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController controllers) {
                        controller.complete(controllers);
                      },
                      // onTap: (coordinate) {
                      //   _controller.animateCamera(CameraUpdate.newLatLng(
                      //       LatLng(coordinate.latitude, coordinate.longitude)));
                      // },
                    ),
                    Positioned(
                      bottom: 20,
                      left: MediaQuery.of(context).size.width * 0.2,
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Map2(
                                            latitude: latitude,
                                            longitude: longitude,
                                          )));
                            },
                            elevation: 5,
                            color: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text("Map For Orders",
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 2)),
                            )),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
