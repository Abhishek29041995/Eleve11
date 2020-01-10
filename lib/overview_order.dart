import 'package:circular_check_box/circular_check_box.dart';
import 'package:eleve11/modal/service_list.dart';
import 'package:eleve11/show_directions.dart';
import 'package:eleve11/utils/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverViewOrder extends StatefulWidget {
  List<ServiceList> serviceList;

  OverViewOrder(List<ServiceList> serviceList) {
    this.serviceList = serviceList;
  }

  _OverViewOrderState createState() => _OverViewOrderState(this.serviceList);
}

class _OverViewOrderState extends State<OverViewOrder> {
  List<ServiceList> serviceList;
  String isCash = "0";
  TextEditingController _promoCodecontroller = new TextEditingController();

  _OverViewOrderState(List<ServiceList> serviceList) {
    this.serviceList = serviceList;
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Overview",
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
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
//                      SvgPicture.asset(serviceList[index].icon,
//                          allowDrawingOutsideViewBox: true,
//                          height: 30,
//                          width: 30,
//                          color: Color(0xff170e50)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              serviceList[index].name,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              serviceList[index].suv_price,
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      )
                    ],
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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
            child: TextField(
              maxLength: 10,
              controller: _promoCodecontroller,
              style: TextStyle(fontSize: 13.0),
              decoration: new InputDecoration(
                counterStyle: TextStyle(
                  height: double.minPositive,
                ),
                counterText: "",
                labelText: "PROMO CODE",
                hintStyle: TextStyle(fontSize: 13),
                fillColor: Colors.white,
                //fillColor: Colors.green
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCash = "1";
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/imgs/fastpay.png",
                        height: 15,
                      ),
                      (isCash != null && isCash == "1")
                          ? CircularCheckBox(
                              value: true,
                              activeColor: Color(0xff170e50),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onChanged: (bool x) {},
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  height: 18,
                  width: 1,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCash = "2";
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/imgs/cash.png",
                        height: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Pay Cash",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff34a953)),
                      ),
                      (isCash != null && isCash == "2")
                          ? CircularCheckBox(
                              value: true,
                              activeColor: Color(0xff170e50),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              onChanged: (bool x) {},
                            )
                          : SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
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
                      showSucessDialog();
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

  void showSucessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/imgs/drop.svg",
                    allowDrawingOutsideViewBox: true,
                    height: 40,
                    width: 40,
                  ),
                  Text(
                    "THANK YOU!",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "FOR ORDERING ELVEVE 11,\nYOU JUST HELPED US SAVE",
                    style: TextStyle(fontSize: 13, fontFamily: 'Montserrat'),
                  ),
                  Text(
                    "7,000,000",
                    style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Color(0xff68CCEA)),
                  ),
                  Text(
                    "litres of water",
                    style: TextStyle(fontSize: 13, fontFamily: 'Montserrat'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20),
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: double.infinity, minHeight: 35.0),
                        child: RaisedButton(
                            child: new Text("OK"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new ShowDirections()));
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
          );
        });
  }
}
