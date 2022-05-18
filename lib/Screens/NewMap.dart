import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_project/Screens/Mapscreen.dart';

class Map2 extends StatefulWidget {
  @override
  _Map2State createState() => _Map2State();

  double latitude, longitude;
  Map2({this.latitude, this.longitude});
}

class _Map2State extends State<Map2> {
  Completer<GoogleMapController> controller = Completer();

  @override
  Widget build(BuildContext context) {
    List<Marker> allMarkers = [
      Marker(
          markerId: MarkerId("mYMarker"),
          position: LatLng(widget.latitude, widget.longitude))
    ];

    return Scaffold(
        body: widget.latitude != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Stack(
                  children: [
                    GoogleMap(
                      markers: Set.from(allMarkers),
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.latitude, widget.longitude),
                        zoom: 12.0,
                      ),
                      onMapCreated: (GoogleMapController controllers) {
                        controller.complete(controllers);
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      left: MediaQuery.of(context).size.width * 0.2,
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Maps()));
                            },
                            elevation: 5,
                            color: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text("Back to Home",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  )),
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
