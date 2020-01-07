import 'package:eleve11/widgets/dashed_line.dart';
import 'package:flutter/material.dart';

class CheckOrderHistoryDetails extends StatefulWidget {
  @override
  _CheckOrderHistoryDetails createState() => _CheckOrderHistoryDetails();
}

class _CheckOrderHistoryDetails extends State<CheckOrderHistoryDetails> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardData1()
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
                                    MediaQuery.of(context).size.height / 7,
                                    fit: BoxFit.fitHeight),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text("John Rocks",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,fontSize: 20)),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  new Text("12 Dec 2019 ",style: TextStyle(
                                      color: Colors.black,fontSize: 16)),
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
                                width:
                                MediaQuery.of(context).size.width / 10,
                                height:
                                MediaQuery.of(context).size.height / 20,
                                fit: BoxFit.fitHeight),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Service Number:",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,fontSize: 16)),
                              SizedBox(
                                height: 5.0,
                              ),
                              new Text("SERVC2019345456",style: TextStyle(
                                  color: Colors.black,fontSize: 14)),
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
                                      shape: BoxShape.circle, color: Colors.red),
                                ),
                                SizedBox(width: 5.0),
                                Text("Booking Date:12 Dec 2019",style: TextStyle(
                                    color: Colors.black,fontSize: 14)),
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
                                      shape: BoxShape.circle, color: Colors.green),
                                ),
                                SizedBox(width: 5.0),
                                Text("Booking Date:12 Dec 2019",style: TextStyle(
                                    color: Colors.black,fontSize: 14)),
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
                                new Text("Ordered On:",style: TextStyle(
                                    color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold,)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text("12 Dec 2019",style: TextStyle(
                                    color: Colors.black,fontSize: 14)),
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
                                new Text("Price:",style: TextStyle(
                                  color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold,)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text("100",style: TextStyle(
                                    color: Colors.black,fontSize: 14)),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ))));
  }

  CardData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 10,
                  child: new IconButton(
                    icon: new Icon(Icons.person_outline, color: Colors.grey),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Service Number:BK1235656667"),
                Text("Booking Date:12 Dec 2019"),
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
                    Text("Booking Date:12 Dec 2019"),
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
                    Text("Booking Date:12 Dec 2019"),
                  ],
                ),

                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
//        Column(
//          children: <Widget>[
//            Container(
//              width: MediaQuery.of(context).size.width/7,
//              child: new IconButton(
//                icon: new Icon(Icons.person_outline,color: Colors.grey),
//              ),
//            )
//          ],
//        ),
          ],
        ),
      ),
    );
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
