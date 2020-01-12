import 'package:eleve11/modal/orders.dart';
import 'package:eleve11/widgets/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CheckOrderHistoryDetails extends StatefulWidget {
  Orders orderList;

  CheckOrderHistoryDetails(Orders orderList) {
    this.orderList = orderList;
  }

  @override
  _CheckOrderHistoryDetails createState() =>
      _CheckOrderHistoryDetails(this.orderList);
}

class _CheckOrderHistoryDetails extends State<CheckOrderHistoryDetails> {
  Orders orderList;

  _CheckOrderHistoryDetails(Orders orderList) {
    this.orderList = orderList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
//          backgroundColor: Color(0xffFF9800),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                const Color(0xff0463EA),
                const Color(0xff09C1F8),
              ],
            ),
          ),
        ),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
                  Navigator.of(context).pop(),
                }),
        automaticallyImplyLeading: false,
        title: new Text("Check Order History Details"),

        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      backgroundColor: Color(0xffF2F2F2),
      body: Center(
//        child: Padding(padding: EdgeInsets.all(5.0),
          child: ListView(
        children: <Widget>[
          CardData1(),
          Card(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                      onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>  viewDetailsPage()),
//                    );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Text("Service Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16)),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                            child: Text(orderList.service['name']),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: HtmlWidget(
                              orderList.service['description'],
                              webView: true,
                            ),
                          )
                        ],
                      )))),
          Card(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                      onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>  viewDetailsPage()),
//                    );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Text("Address Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                                orderList.address['house'] +
                                    ",\nnear " +
                                    orderList.address['landmark'],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RaisedButton.icon(
                              icon: Icon(Icons.location_on),
                              color: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              elevation: 0,
                              label: Flexible(
                                child: Text(orderList.address['address'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold)),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ))))
        ],
      )
//        ),
          ),
    );
  }

  CardData1() {
    return
//      GestureDetector(
//        onTap: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) =>  viewDetailsPage()),
//          );
//    },
//    child:
        Card(
            child: Container(
                child: InkWell(
                    onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>  viewDetailsPage()),
//                    );
                    },
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image(
                                      image: AssetImage('assets/user.png'),
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      fit: BoxFit.fitHeight),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text("John Rocks",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20)),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    new Text("12 Dec 2019 ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage('assets/invoice1.png'),
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fitHeight),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                  image: AssetImage('assets/invoice1.png'),
                                  width: MediaQuery.of(context).size.width / 10,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  fit: BoxFit.fitHeight),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("Reference Number:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(orderList.booking_ref,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text("Booking Date:" + orderList.created_at,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Dash(
                                    direction: Axis.vertical,
                                    length: 10,
                                    dashLength: 2,
                                    dashColor: Colors.grey),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text("Booking Date:" + orderList.created_at,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text("Ordered On:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  new Text(orderList.updated_at,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text("Price:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  new Text(orderList.discounted_price,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ))));
  }
}

class MySeparator extends StatelessWidget {
  final double width;
  final Color color;

  const MySeparator({this.width = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
//        final boxWidth = constraints.constrainWidth();
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = 2.0;
        final dashCount = (boxWidth / dashWidth).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
        );
      },
    );
  }
}
