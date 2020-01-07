import 'package:eleve11/checkOrderHistoryDetails.dart';
import 'package:eleve11/widgets/dashed_line.dart';
import 'package:flutter/material.dart';

class CheckOrderHistory extends StatefulWidget {
  @override
  _CheckOrderHistory createState() => _CheckOrderHistory();
}

class _CheckOrderHistory extends State<CheckOrderHistory> {
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
        title: new Text("Check Order History"),

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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[bodyCard()],
      )
//        ),
          ),
    );
  }

  bodyCard() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
//          final item = finalDepData[index];
//          return tableRowDept(item);
          return CardData();
        },
      ),
    );
  }

  CardData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckOrderHistoryDetails()),
          );
        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Image(
                        image: AssetImage('assets/smart-car.png'),
                        width: 30,
                        height: 30,
                        fit: BoxFit.fitHeight),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("# BK1235656667",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Ordered On:12 Dec 2019",
                          style:
                          TextStyle(color: Colors.black, fontSize: 11)),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                          ),
                          SizedBox(width: 5.0),
                          Text("Booking Date:12 Dec 2019" ,style:
                              TextStyle(color: Colors.black, fontSize: 11)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Dash(
                            direction: Axis.vertical,
                            length: 10,
                            dashLength: 2,
                            dashColor: Colors.red),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                          SizedBox(width: 5.0),
                          Text("Booking Date:12 Dec 2019" ,style:
                          TextStyle(color: Colors.black, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Text("\$80",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                          image: AssetImage('assets/user.png'),
                          height: 35,
                          width: 35,
                          fit: BoxFit.fitHeight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class MySeparator extends StatelessWidget {
//  final double height;
//  final Color color;
//
//  const MySeparator({this.height = 1, this.color = Colors.black});
//
//  @override
//  Widget build(BuildContext context) {
//    return LayoutBuilder(
//      builder: (BuildContext context, BoxConstraints constraints) {
//        final boxWidth = constraints.constrainWidth();
//        final dashWidth = 10.0;
//        final dashHeight = height;
//        final dashCount = (boxWidth / (2 * dashWidth)).floor();
//        return Flex(
//          children: List.generate(dashCount, (_) {
//            return SizedBox(
//              width: dashWidth,
//              height: dashHeight,
//              child: DecoratedBox(
//                decoration: BoxDecoration(color: color),
//              ),
//            );
//          }),
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          direction: Axis.horizontal,
//        );
//      },
//    );
//  }
//}
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
