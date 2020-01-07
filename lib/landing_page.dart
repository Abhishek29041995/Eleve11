import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:eleve11/add_location.dart';
import 'package:eleve11/application.dart';
import 'package:eleve11/booking_history.dart';
import 'package:eleve11/checkOrderHistory.dart';
import 'package:eleve11/feedback.dart';
import 'package:eleve11/login.dart';
import 'package:eleve11/modal/locale.dart';
import 'package:eleve11/modal/service_new.dart';
import 'package:eleve11/profile_design.dart';
import 'package:eleve11/select_service.dart';
import 'package:eleve11/utils/translations.dart';
import 'package:eleve11/widgets/custom_radio.dart';
import 'package:eleve11/offers_page.dart';
import 'package:eleve11/widgets/searchMapPlaceWidget.dart';
import 'package:eleve11/widgets/user_accounts_drawer_header.dart' as prefix1;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  String radioValue = "";

  LandingPage();

  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static LatLng _initialPosition;
  bool _isLoading = true;
  bool isConfirmed = false;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();
  Position userLocation;
  var location = new Location();
  CameraPosition _currentPosition = CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  );
  BitmapDescriptor myIcon;
  LatLng _originLocation = LatLng(0, 0);
  LatLng _destinationLocation = LatLng(0, 0);
  RadioBuilder<String, dynamic> dynamicBuilder;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 15.0;
  final double _initFabHeight = 120.0;
  double _fabHeight;
  bool showfooter = true;
  List<Services> services = new List();
  ui.Image labelIcon;
  ui.Image markerImage;
  String locationTitle = "";
  Map userData = null;

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

  @override
  Future initState() {
    checkIsLogin();
    _fabHeight = _initFabHeight;
    services = getServices();
    _getLocation();
    setIcons();
    setRadioItems();

    loadlabel("assets/imgs/map_user.png");
    load("assets/imgs/gps.png");
    super.initState();
  }

  Future<Null> checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonCodec codec = new JsonCodec();
    userData = codec.decode(prefs.getString("userData"));
    print(userData);
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

  load(String asset) {
    ui.Image image;
    rootBundle.load(asset).then((bd) {
      Uint8List lst = new Uint8List.view(bd.buffer);
      ui.instantiateImageCodec(lst).then((codec) {
        codec.getNextFrame().then((frameInfo) {
          image = frameInfo.image;
          setState(() {
            markerImage = image;
          });
        });
      });
    });
  }

  loadlabel(String asset) {
    ui.Image image;
    rootBundle.load(asset).then((bd) {
      Uint8List lst = new Uint8List.view(bd.buffer);
      ui.instantiateImageCodec(lst).then((codec) {
        codec.getNextFrame().then((frameInfo) {
          image = frameInfo.image;
          setState(() {
            labelIcon = image;
          });
        });
      });
    });
  }

  _onTap(LatLng point) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder,
        Rect.fromPoints(const Offset(0.0, 0.0), const Offset(200.0, 200.0)));
    final Paint paint = Paint()
      ..color = Colors.black.withOpacity(1)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(0.0, 0.0, 152.0, 48.0),
            const Radius.circular(4.0)),
        paint);
    paintText(canvas);
    paintImage(labelIcon, const Rect.fromLTWH(8, 8, 32.0, 32.0), canvas, paint,
        BoxFit.contain);
    paintImage(markerImage, const Rect.fromLTWH(24.0, 48.0, 110.0, 110.0),
        canvas, paint, BoxFit.contain);
    final ui.Picture picture = recorder.endRecording();
    final img = await picture.toImage(200, 200);
    final pngByteData = await img.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      myIcon = BitmapDescriptor.fromBytes(Uint8List.view(pngByteData.buffer));
    });
  }

  void paintText(Canvas canvas) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    final textSpan = TextSpan(
      text: '18 mins',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 88,
    );
    final offset = Offset(48, 8);
    textPainter.paint(canvas, offset);
  }

  void paintImage(ui.Image image, Rect outputRect, Canvas canvas, Paint paint,
      BoxFit fit) {
    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect =
    Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
    Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
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
        drawer: Drawer(
          child: userData!=null?ListView(
            children: <Widget>[
              prefix1.UserAccountsDrawerHeader(
                accountName: Text(
                  userData['name'],
                  style: TextStyle(fontSize: 11, color: Color(0xff170e50)),
                ),
                accountEmail: Text(
                  userData['email'],
                  style: TextStyle(fontSize: 11, color: Color(0xff170e50)),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme
                      .of(context)
                      .platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
                  child: new ClipRRect(
                    borderRadius: new BorderRadius.circular(100),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
//                                Navigator.push(
//                                    context,
//                                    new MaterialPageRoute(
//                                        builder: (context) => new SelectService()));
                          },
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/imgs/user.png',
                            image: userData['avatar'],
                            fit: BoxFit.cover,
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(
                  Icons.info,
                  color: Color(0xff170e50),
                ),
                title: new Text(
                    Translations.of(context).text('about') + ' Eleve11'),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading:
                new Icon(Icons.account_circle, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('profile')),
                onTap: () => _onListTileTap(context, "profile"),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.drive_eta, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('my_rides')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.my_location, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('my_locations')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading:
                new Icon(Icons.favorite_border, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('my_orders')),
                onTap: () => _onListTileTap(context, "my_order"),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.feedback, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('feedback')),
                onTap: () => _onListTileTap(context, "feedback"),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.confirmation_number,
                    color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('promo_codes')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.local_offer, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('offers')),
                onTap: () => _onListTileTap(context, "offers"),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading:
                new Icon(Icons.notifications, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('notifications')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new Divider(),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.settings, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('settings')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading:
                new Icon(Icons.question_answer, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('faq')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.call, color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('contacts')),
                onTap: () => _onListTileTap(context, ""),
              ),
              new ExpansionTile(
                leading: new Icon(Icons.g_translate, color: Color(0xff170e50)),
                title: Text("Change Language"),
                children: <Widget>[
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Text(
                      "English",
                      textAlign: TextAlign.center,
                    ),
                    onTap: () =>
                    {
                      Navigator.of(context).pop(),
                      Provider.of<LocaleModel>(context)
                          .changelocale(Locale("en"))
                    },
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Text(
                      "Arabic",
                      textAlign: TextAlign.center,
                    ),
                    onTap: () =>
                    {
                      Navigator.of(context).pop(),
                      Provider.of<LocaleModel>(context)
                          .changelocale(Locale("ar"))
                    },
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Text(
                      "Kurdish",
                      textAlign: TextAlign.center,
                    ),
                    onTap: () =>
                    {
                      Navigator.of(context).pop(),
                      Provider.of<LocaleModel>(context)
                          .changelocale(Locale("ku"))
                    },
                  ),
                ],
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.new_releases, color: Color(0xff170e50)),
                title: new Text("App version"),
                trailing: new Text(
                  "v1.0.0",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              ),
              new ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                leading: new Icon(Icons.power_settings_new,
                    color: Color(0xff170e50)),
                title: new Text(Translations.of(context).text('logout')),
                onTap: () => _onListTileTap(context, "logout"),
              ),
            ],
          ):Container(),
        ),
        body: Stack(
          children: _buildMap(context),
        ),
        //this will just add the Navigation Drawer Icon
      ),
    );
  }

  _onListTileTap(BuildContext context, String from) {
    Navigator.of(context).pop();
    if (from == "logout") {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(Translations.of(context).text('logout')),
                content:
                Text(Translations.of(context).text('are_u_sure_logout')),
                actions: <Widget>[
                  FlatButton(
                    child: Text(Translations.of(context).text('no')),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  FlatButton(
                      child: Text(Translations.of(context).text('yes')),
                      onPressed: () =>
                      {
                        clearPreference(context),
                      }),
                ],
              ));
    } else if (from == "history") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new BookingHistory()));
    } else if (from == "feedback") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new FeedackPage()));
    } else if (from == "profile") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new ProfilePageDesign()));
    } else if (from == "my_order") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new CheckOrderHistory()));
    } else if (from == "offers") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new OffersPage()));
    } else {
      showDialog<Null>(
        context: context,
        builder: (_) =>
        new AlertDialog(
          title: const Text('Not Implemented'),
          actions: <Widget>[
            new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Future<Null> clearPreference(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('accessToken', '');
    prefs.setString('userData', '');
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(
          builder: (context) => new LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  List<Widget> _buildMap(BuildContext context) {
    var list = new List<Widget>();
    var mapView = new GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _currentPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
    );
    var footerView = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          !isConfirmed
              ? Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: new BoxDecoration(
                color: const Color(0xFFFFFFFF),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                                size: 14,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              locationTitle,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 14,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Color(0xff170e50),
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new AddLocation()));
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 8),
                    child: Divider(),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: services.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  child: CustomRadio<String, dynamic>(
                                    services: services[index],
                                    value: services[index].radioButton,
                                    groupValue: widget.radioValue,
                                    animsBuilder: (AnimationController
                                    controller) =>
                                    [
                                      CurvedAnimation(
                                          parent: controller,
                                          curve: Curves.easeInOut),
                                      ColorTween(
                                          begin: Colors.white,
                                          end: Colors.deepPurple)
                                          .animate(controller),
                                      ColorTween(
                                          begin: Colors.deepPurple,
                                          end: Colors.white)
                                          .animate(controller),
                                    ],
                                    builder: dynamicBuilder,
                                  ),
                                ),
                                Text(
                                  services[index].name,
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20),
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: double.infinity, minHeight: 35.0),
                        child: RaisedButton(
                            child: new Text(
                                Translations.of(context).text('confirm')),
                            onPressed: () {
                              setState(() {
                                isConfirmed = true;
                              });
                            },
                            textColor: Colors.white,
                            color: Color(0xff170e50),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(30.0)))),
                  )
                ],
              ),
            ),
          )
              : Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: new BoxDecoration(
                color: const Color(0xFFFFFFFF),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmed = false;
                          });
                        },
                      ),
                      Text(
                        "MY RIDES",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 24,
                      ),
//                          IconButton(
//                            icon: Icon(
//                              Icons.add_circle,
//                              color: Color(0xff170e50),
//                              size: 24,
//                            ),
//                            onPressed: () {},
//                          ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext ctxt, int index) {
                          if (index == 3)
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 120,
                                      child: new ClipRRect(
                                        borderRadius:
                                        new BorderRadius.circular(
                                            8.0),
                                        child: Stack(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                        new SelectService()));
                                              },
                                              child: Container(
                                                height: 120,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color:
                                                    Colors.black12),
                                                child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Icon(Icons.add),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: Text(
                                                            "Add New"),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          else
                            return _buildItem(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ]);
    list.add(mapView);
    if (showfooter) {
      list.add(footerView);
    }
    var appBar = Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(Icons.menu),
          color: Colors.black,
        )
      ],
    );
    list.add(appBar);
    var searchbar = Positioned(
        top: 60,
        left: MediaQuery
            .of(context)
            .size
            .width * 0.05,
        // width: MediaQuery.of(context).size.width * 0.9,
        child: SearchMapPlaceWidget(
          apiKey: "AIzaSyBGATn-87XZC0qqYEi5Q5rdDLkWcSB1F4s",
          location: _currentPosition.target,
          radius: 30000,
          onSelected: (place) async {
            final geolocation = await place.geolocation;

            final GoogleMapController controller = await _controller.future;

            controller
                .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
            controller.animateCamera(
                CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
          },
        ));
    list.add(searchbar);

//    if (showfooter) {
//      list.add(footerView);
//    }
    if (_isLoading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: SpinKitRotatingPlain(
              itemBuilder: _customicon,
            ),
          ),
        ],
      );
      list.add(modal);
    }
    return list;
  }

  Future getLocationAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      locationTitle = first.subLocality;
    });
  }

  Widget _customicon(BuildContext context, int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/imgs/logo.png"),
      ),
      decoration: new BoxDecoration(
          color: Color(0xff170e50),
          borderRadius: new BorderRadius.circular(5.0)),
    );
  }

  void getUpdatedLocation() {
    location.onLocationChanged().listen((LocationData currentLocation) {
      new Timer(new Duration(milliseconds: 2000), () {
        _UpdateCurrentLocation(CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 14.4746,
        ));

        getLocationAddress(currentLocation.latitude, currentLocation.longitude);
        if (markers.length > 0) {
          markers.remove(markers.firstWhere((Marker marker) =>
          marker.markerId == MarkerId("currentLocation")));
        }
        markers.add(Marker(
          markerId: MarkerId("currentLocation"),
          icon: myIcon,
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          onTap: () =>
              _onTap(
                  LatLng(currentLocation.latitude, currentLocation.longitude)),
        ));
        setState(() {
          _originLocation =
              LatLng(currentLocation.latitude, currentLocation.longitude);
          _destinationLocation = LatLng(20.2921956, 85.8392707);
          _isLoading = false;
        });
      });
    });
  }

  void setRadioItems() {
    dynamicBuilder = (BuildContext context, List<dynamic> animValues,
        Function updateState, Services services, String value) {
      return GestureDetector(
          onTap: () {
            setState(() {
              widget.radioValue = value;
            });
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
              padding: EdgeInsets.all(6.0 + animValues[0] * 6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: animValues[1],
              ),
              child: Image.asset("assets/imgs/logo.png")));
    };
  }

  List<Services> getServices() {
    return [
      Services("", "WASH", "0", "1"),
//      Services("", "MAINTAINANCE", "1", "2"),
//      Services("", "SPECIAL CARE", "1", "3"),
    ];
  }

  Future setIcons() async {
    myIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/imgs/gps.png', 100));
  }

  _buildItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120,
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new SelectService()));
                    },
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/imgs/placeholder.png',
                      image:
                      "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201709/lamborghini_story_647_090817040539.jpg",
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Avendator",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}