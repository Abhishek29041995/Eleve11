import 'dart:convert';

import 'package:eleve11/modal/manufacturer_list.dart';
import 'package:eleve11/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRide extends StatefulWidget {
  _AddRideState createState() => _AddRideState();
}

class _AddRideState extends State<AddRide> {
  Map userData = null;
  String acccessToken = "";
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ManufacturerList> manufacturerList = new List();
  List<ManufacturerList> modelList = new List();

  bool ismanufactufrer = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        if (ismanufactufrer) {
          return true;
        } else {
          setState(() {
            ismanufactufrer = true;
            return false;
          });
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: _buildWidget(context),
          )),
    ));
  }

  Future<Null> checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonCodec codec = new JsonCodec();
    userData = codec.decode(prefs.getString("userData"));
    acccessToken = prefs.getString("accessToken");
    getCarManufactureList();
  }

  List<Widget> _buildWidget(BuildContext context) {
    var list = new List<Widget>();
    var appBar = Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Add Ride",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff170e50)),
            ),
          )
        ],
      ),
    );
    list.add(appBar);
    var manufacturerGrid = Padding(
      padding: EdgeInsets.only(top: 56),
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            ismanufactufrer ? manufacturerList.length : modelList.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Manufacturer(ismanufactufrer
                        ? manufacturerList[index]
                        : modelList[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    list.add(manufacturerGrid);
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

  addMyRide(String id, String type) {
    setState(() {
      _isLoading = true;
    });
    var request =
        new MultipartRequest("POST", Uri.parse(api_url + "user/addToMyRide"));
    request.fields['car_model_id'] = id;
    request.fields['type'] = type;
    request.headers['Authorization'] = "Bearer $acccessToken";
    commonMethod(request).then((onResponse) {
      onResponse.stream.transform(utf8.decoder).listen((value) {
        setState(() {
          _isLoading = false;
        });
        Map data = json.decode(value);
        presentToast(data['message'], context, 0);
        if (data['code'] == 200) {
          Navigator.of(context).pop();
        }
      });
    });
  }

  void getCarManufactureList() {
    setState(() {
      _isLoading = true;
    });
    var request = new MultipartRequest(
        "GET", Uri.parse(api_url + "user/getCarManufactureList"));
    request.headers['Authorization'] = "Bearer $acccessToken";
    commonMethod(request).then((onResponse) {
      onResponse.stream.transform(utf8.decoder).listen((value) {
        setState(() {
          _isLoading = false;
        });
        Map data = json.decode(value);
        print(data);
        if (data['code'] == 200) {
          if (data['data'].length > 0) {
            List<ManufacturerList> tempList = new List();
            for (var i = 0; i < data['data'].length; i++) {
              tempList.add(new ManufacturerList(
                  data['data'][i]['id'].toString(),
                  data['data'][i]['name'],
                  data['data'][i]['image'],
                  "",
                  data['data'][i]['created_at'],
                  data['data'][i]['updated_at']));
            }
            setState(() {
              manufacturerList = tempList;
            });
          } else {
            presentToast("No record found", context, 0);
          }
        } else {
          presentToast(data['message'], context, 0);
        }
      });
    });
  }

  void getCarModelList(String id) {
    setState(() {
      _isLoading = true;
    });
    var request = new MultipartRequest(
        "GET", Uri.parse(api_url + "user/getCarModelList/" + id));
    request.headers['Authorization'] = "Bearer $acccessToken";
    commonMethod(request).then((onResponse) {
      onResponse.stream.transform(utf8.decoder).listen((value) {
        setState(() {
          _isLoading = false;
        });
        Map data = json.decode(value);
        print(data);
        presentToast(data['message'], context, 0);
        if (data['code'] == 200) {
          if (data['data'].length > 0) {
            List<ManufacturerList> tempList = new List();
            for (var i = 0; i < data['data'].length; i++) {
              tempList.add(new ManufacturerList(
                  data['data'][i]['id'].toString(),
                  data['data'][i]['name'],
                  data['data'][i]['image'],
                  data['data'][i]['type'],
                  data['data'][i]['created_at'],
                  data['data'][i]['updated_at']));
            }
            setState(() {
              modelList = tempList;
              ismanufactufrer = false;
            });
          } else {
            presentToast("No record found", context, 0);
          }
        } else {
          presentToast(data['message'], context, 0);
        }
      });
    });
  }

  Manufacturer(ManufacturerList manufacturerList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                ismanufactufrer
                    ? getCarModelList(manufacturerList.id)
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            //this right here
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Are you sure you want to add?",
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: 'Montserrat'),
                                  ),
                                  FadeInImage.assetNetwork(
                                    placeholder: 'assets/imgs/placeholder.png',
                                    image: manufacturerList.image,
                                  ),
                                  Text(
                                    manufacturerList.name +
                                        "( " +
                                        manufacturerList.type +
                                        " )",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 20),
                                          child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  minWidth: double.infinity,
                                                  minHeight: 35.0),
                                              child: RaisedButton(
                                                  child: new Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                  textColor: Colors.white,
                                                  color: Colors.red,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  30.0)))),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 20),
                                          child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  minWidth: double.infinity,
                                                  minHeight: 35.0),
                                              child: RaisedButton(
                                                  child: new Text("Add"),
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    addMyRide(
                                                        manufacturerList.id,
                                                        manufacturerList.type);
                                                  },
                                                  textColor: Colors.white,
                                                  color: Color(0xff170e50),
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  30.0)))),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
              },
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/imgs/placeholder.png',
                image: manufacturerList.image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              manufacturerList.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
