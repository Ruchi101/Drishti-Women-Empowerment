import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:convert';
import 'package:google_maps_webservice/places.dart' as gmwplaces;
import 'package:google_maps_webservice/directions.dart' as gmwdirections;
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;

void main() {
  runApp(MapPage());
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

TextEditingController toController = TextEditingController(text: "");
TextEditingController fromController = TextEditingController();

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Paytm Hack",
      home: Scaffold(
        //appBar: AppBar(title: const Text('Google Maps demo')),
        body: MapsDemo(),
      ),
    );
  }
}

var location = loc.Location();
String destination = "Maujpur Metro Station";
gmwdirections.Location dest = gmwdirections.Location(0.0, 0.0),
    begin = gmwdirections.Location(0.0, 0.0);
GoogleMapController mapController;
bool isStartVisible = false;
Image img;

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                options: GoogleMapOptions(),
              ),
              (img != null) ? img : Container(),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.blue,
                              )),
                          child: TextFormField(
                            controller: toController,
                            onFieldSubmitted: (str) => SearchLocation(),
                            decoration: InputDecoration(
                                labelText: "To",
                                contentPadding: EdgeInsets.all(5.0)),
                          )),
                    ),
                  ],
                ),
              ),
              (!isStartVisible)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: RaisedButton(
                            onPressed: () {},
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.lightbulb_outline,
                                color: Colors.white,
                                size: 40.0,
                              ),
                            ),
                            shape: CircleBorder(),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 10.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100.0),
                                border:
                                    Border.all(color: Colors.blue, width: 2.0)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: FlatButton(
                                    child: Container(),
                                    onPressed: () {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              "Rated (28.667354 , 77.2371020) as Good")));
                                    },
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  child: FlatButton(
                                    child: Container(),
                                    onPressed: () {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              "Rated (28.667354 , 77.2371020) as Good")));
                                    },
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: FlatButton(
                                    child: Container(),
                                    onPressed: () {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              "Rated (28.667354 , 77.2371020) as Good")));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(),
              (!isStartVisible)
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: RaisedButton(
                              onPressed: () {},
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.settings_input_antenna,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: RaisedButton(
                              onPressed: () async {
                                print("Getting img");
                                var response = await http
                                    .get("http://ayush789.pythonanywhere.com/");
                                print(response.body);
                                var bytes = base64Decode(response.body);
                                setState(() {
                                  img = Image.memory(
                                    bytes,
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  );
                                });
                              },
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  img = null;
                                });
                              },
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.map,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {},
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.local_taxi,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              (isStartVisible)
                  ? Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      isStartVisible = false;
                                    });
                                  },
                                  child: Text(
                                    "Start",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: CircleAvatar(
                                  minRadius: 30.0,
                                  backgroundColor: Colors.blue,
                                  child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {
                                        setState(() {
                                          isStartVisible = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 30.0,
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: FlatButton(
            child: Text(
              "Call For Help",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            color: Colors.red,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      location.getLocation().then((Map<String, double> myloc) {
        setState(() {
          begin = gmwdirections.Location(myloc["latitude"], myloc["longitude"]);
        });
        mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(myloc["latitude"], myloc["longitude"]),
              zoom: 17.0,
            ),
          ),
        );
        /*
        mapController.addMarker(MarkerOptions(
          position: LatLng(myloc["latitude"], myloc["longitude"]),
        ));*/
      });
    });
  }

  void SearchLocation() async {
    if (toController.text == "") return;
    var places = gmwplaces.GoogleMapsPlaces(
      apiKey: "AIzaSyApZJZMg-ArN-9i6qjDRlrXNF0tPM3-G4I",
    );
    var val = await places.searchByText(toController.text).catchError((e) {
      print("Error: $e}");
      return;
    });
    print(val.results.length);
    if (val.results.length == 0) {
      return;
    }
    dest = val.results[0].geometry.location;
    print("New Dest $dest");

    mapController.clearMarkers();
    mapController.clearPolylines();
    mapController.addMarker(
      MarkerOptions(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(dest.lat, dest.lng),
      ),
    );
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(begin.lat, begin.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    var directions = gmwdirections.GoogleMapsDirections(
      apiKey: "AIzaSyApZJZMg-ArN-9i6qjDRlrXNF0tPM3-G4I",
    );
    var dirresp =
        await directions.directionsWithLocation(begin, dest).catchError(
      (e) {
        print("Error: $e}");
        return;
      },
    );
    print(dirresp.routes.length);

    dirresp.routes.forEach((route) {
      List<LatLng> points = [];
      double e, w, n, s;
      e = w = begin.lng;
      n = s = begin.lat;
      points.add(LatLng(begin.lat, begin.lng));
      double totalDistance = 0;
      route.legs[0].steps.forEach(
        (gmwdirections.Step step) {
          n = (n > step.endLocation.lat) ? n : step.endLocation.lat;
          s = (s < step.endLocation.lat) ? s : step.endLocation.lat;
          e = (e > step.endLocation.lng) ? e : step.endLocation.lng;
          w = (w < step.endLocation.lng) ? w : step.endLocation.lng;

          points.add(
            LatLng(step.endLocation.lat, step.endLocation.lng),
          );
          totalDistance += step.distance.value;
        },
      );
      points.add(LatLng(dest.lat, dest.lng));
      n = (n > dest.lat) ? n : dest.lat;
      s = (s < dest.lat) ? s : dest.lat;
      e = (e > dest.lng) ? e : dest.lng;
      w = (w < dest.lng) ? w : dest.lng;

      print(n);
      print(s);
      print(w);
      print(e);

      print("Total Distance : $totalDistance");

      n += (n - s) * 0.23;
      e -= (w - e) * 0.2;
      print(n);
      print(s);
      print(w);
      print(e);

      //mapController.addMarker(MarkerOptions(position: LatLng(n, e)));
      //mapController.addMarker(MarkerOptions(position: LatLng(s, w)));
      mapController.addPolyline(PolylineOptions(
        points: points,
        color: Colors.purple.value,
        endCap: Cap.squareCap,
      ));
      mapController.moveCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(s, w),
              northeast: LatLng(n, e),
            ),
            20.0),
      );
    });
    print("Changed");
    setState(() {
      isStartVisible = true;
    });
  }

  Future sendReview(double lat,double lon, int review) async {
    String url = "http://ayush789.pythonanywhere.com/addreview?lat=$lat&lon=$lon&rev=$review";

    var response = await http.get(url);
    print(response);
    return;
  }

  void UpdateLocation(){
    setState(() {
     location.getLocation().then((v){});
    });
  }
}
