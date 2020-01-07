import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:eleve11/utils/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddLocation extends StatefulWidget {
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var location = new Location();
  CameraPosition _currentPosition = CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  );
  Set<Marker> markers = Set();
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  BitmapDescriptor myIcon;
  bool _isLoading = true;

  String locationTitle = "";
  String fulladdress = "";

  TextEditingController _address1controller = new TextEditingController();
  TextEditingController _address2controller = new TextEditingController();

  @override
  void initState() {
    _getLocation();
    setIcons();
    super.initState();
  }

  Future _getLocation() async {
    try {
      if (location.serviceEnabled() == true) {
        getUpdatedLocation();
      } else {
        location.requestPermission().then((onValue) {
          if (onValue == true) {
            getUpdatedLocation();
          } else {
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    } catch (e) {
      print('ERROR:$e');
      currentLocation = null;
    }
  }

  void getUpdatedLocation() {
    location.getLocation().then((LocationData currentlocation) {
      if (markers.length > 0) {
        markers.remove(markers.firstWhere(
            (Marker marker) => marker.markerId == MarkerId("currentLocation")));
      }
      setState(() {
        markers.add(Marker(
            markerId: MarkerId("currentLocation"),
            icon: myIcon,
            draggable: true,
            position:
                LatLng(currentlocation.latitude, currentlocation.longitude),
            onDragEnd: ((value) {
              getLocationAddress(value.latitude, value.longitude);
            })));
      });
      new Timer(new Duration(milliseconds: 2000), () {
        _UpdateCurrentLocation(CameraPosition(
          target: LatLng(currentlocation.latitude, currentlocation.longitude),
          zoom: 14.4746,
        ));

        getLocationAddress(currentlocation.latitude, currentlocation.longitude);
      });
    });
  }

  Future<void> _UpdateCurrentLocation(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body: Stack(
              children: _buildMap(context),
            )));
  }

  List<Widget> _buildMap(BuildContext context) {
    var list = new List<Widget>();
    var mapView = new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _currentPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
    list.add(mapView);
    var address = Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(Icons.location_on),
                color: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                label: Text(locationTitle,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold)),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RawMaterialButton(
                  fillColor: Colors.black12,
                  constraints: BoxConstraints(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(5),
                  elevation: 0,
                  child: Text("CHANGE",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.deepOrange,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(fulladdress,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Montserrat',
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
            child: TextField(
              maxLength: 10,
              controller: _address1controller,
              style: TextStyle(fontSize: 13.0),
              decoration: new InputDecoration(
                counterStyle: TextStyle(
                  height: double.minPositive,
                ),
                counterText: "",
                labelText: "HOUSE/FLAT/BLOCK NO.",
                hintStyle: TextStyle(fontSize: 13),
                fillColor: Colors.white,
                //fillColor: Colors.green
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
            child: TextField(
              maxLength: 10,
              controller: _address2controller,
              style: TextStyle(fontSize: 13.0),
              decoration: new InputDecoration(
                counterStyle: TextStyle(
                  height: double.minPositive,
                ),
                counterText: "",
                labelText: "LANDMARK",
                hintStyle: TextStyle(fontSize: 13),
                fillColor: Colors.white,
                //fillColor: Colors.green
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, minHeight: 35.0),
                child: RaisedButton(
                    child: new Text(Translations.of(context).text('confirm')),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      new Timer(new Duration(milliseconds: 3000), () {
                        setState(() {
                          _isLoading = false;
                          Navigator.of(context).pop();
                        });
                      });
                    },
                    textColor: Colors.white,
                    color: Color(0xff170e50),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)))),
          ),
        ],
      ),
    );
    list.add(address);
    return list;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future setIcons() async {
    myIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/imgs/gps.png', 100));
  }

  Future getLocationAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      locationTitle = first.subLocality;
      fulladdress = first.addressLine;
    });
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  }
}
