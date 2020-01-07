import 'package:circular_check_box/circular_check_box.dart';
import 'package:eleve11/modal/child_services.dart';
import 'package:eleve11/modal/service_list.dart';
import 'package:eleve11/overview_order.dart';
import 'package:eleve11/utils/translations.dart';
import 'package:eleve11/widgets/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eleve11/modal/child_services.dart';

class SelectService extends StatefulWidget {
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ServiceList> serviceList = new List();

  @override
  void initState() {
    // TODO: implement initState
    serviceList = getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SafeArea(
      child: Scaffold(
        body: Stack(
          children: _buildWidget(context),
        ),
      ),
    );
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
          CircleAvatar(
            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                ? Colors.blue
                : Colors.white,
            child: new Container(
                width: 140.0,
                height: 140.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/imgs/logo.png'),
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "WASH",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff170e50)),
            ),
          )
        ],
      ),
    );
    list.add(appBar);
    var servicelist = Padding(
      padding: EdgeInsets.only(top: 80),
      child: ListView.separated(
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 30, right: 10),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
          itemCount: serviceList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ExpandableNotifier(
              // <-- Provides ExpandableController to its children
              child: Column(
                children: [
                  Expandable(
                    // <-- Driven by ExpandableController from ExpandableNotifier
                    collapsed: ExpandableButton(
                      // <-- Expands when tapped on the cover photo
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(serviceList[index].icon,
                                    allowDrawingOutsideViewBox: true,
                                    height: 30,
                                    width: 30,
                                    color: Color(0xff170e50)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        serviceList[index].name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        serviceList[index].price,
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CircularCheckBox(
                              value: serviceList[index].isChecked,
                              activeColor: Color(0xff170e50),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onChanged: (bool x) {
                                setState(() {
                                  serviceList[index].isChecked =
                                      !serviceList[index].isChecked;
                                  if (x) {
                                    for (var i = 0;
                                        i < serviceList.length;
                                        i++) {
                                      if (index != i) {
                                        serviceList[i].isChecked = false;
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: Column(children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(serviceList[index].icon,
                                    allowDrawingOutsideViewBox: true,
                                    height: 30,
                                    width: 30,
                                    color: Colors.green),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        serviceList[index].name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,color: Colors.green),
                                      ),
                                      Text(
                                        serviceList[index].price,
                                        style: TextStyle(fontSize: 13,color: Colors.green),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CircularCheckBox(
                              value: serviceList[index].isChecked,
                              activeColor: Color(0xff170e50),
                              materialTapTargetSize:
                              MaterialTapTargetSize.padded,
                              onChanged: (bool x) {
                                setState(() {
                                  serviceList[index].isChecked =
                                  !serviceList[index].isChecked;
                                  if (x) {
                                    for (var i = 0;
                                    i < serviceList.length;
                                    i++) {
                                      if (index != i) {
                                        serviceList[i].isChecked = false;
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      _childList(serviceList[index].otherservices),
                    ]),
                  ),
                ],
              ),
            );
          }),
    );
    list.add(servicelist);
    var footer = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "95 AED",
                    style: TextStyle(
                      color: Color(0xff170e50),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, minHeight: 35.0),
                child: RaisedButton(
                    child: new Text(Translations.of(context).text('continue')),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new OverViewOrder(
                                  serviceList
                                      .where((i) => i.isChecked == true)
                                      .toList())));
                    },
                    textColor: Colors.white,
                    color: Color(0xff170e50),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)))),
          )
        ]);
    list.add(footer);
    return list;
  }

  List<ServiceList> getServices() {
    List<ChildSerices> childservices1 = new List();
    List<ChildSerices> childservices2 = new List();
    childservices1.add(new ChildSerices("Washing full Body"));
    childservices1.add(new ChildSerices("Shining"));
    childservices1.add(new ChildSerices("Cleaning tyres"));
    childservices1.add(new ChildSerices("Checking tyres pressure"));

    childservices2.add(new ChildSerices("Cleaning engines"));
    childservices2.add(new ChildSerices("Checking engines"));
    return [
      ServiceList("assets/imgs/carwash.svg", "Full Body Wash", "35 AED", false,
          childservices1),
      ServiceList("assets/imgs/car-seat.svg", "Engine Wash", "15 AED", false,
          childservices2),
    ];
  }

  _childList(List<ChildSerices> otherservices) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: otherservices.length,
        itemBuilder: (BuildContext ctxt, int index) {
         return Padding(
            padding: const EdgeInsets.only(left: 40, right: 30, top: 20),
            child: Text(
              otherservices[index].name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
