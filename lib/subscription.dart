import 'dart:math';

import 'package:eleve11/modal/subscription.dart';
import 'package:eleve11/utils/controlled_animation.dart';
import 'package:eleve11/utils/multi_track_tween.dart';
import 'package:eleve11/widgets/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xff6959d2), end: Colors.lightBlue.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xff6959d2), end: Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}

class SubscriptionPlans extends StatefulWidget {
  _SubscriptionPlansState createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends State<SubscriptionPlans>
    with SingleTickerProviderStateMixin {
  List<Subription> subcriptionList = new List();

  List<Subription> addList() {
    List<Subription> temList = new List();
    temList.add(new Subription("Standard", "", "159", "Week"));
    temList.add(new Subription("Business", "", "269", "Month"));
    temList.add(new Subription("Premium", "", "399", "Year"));

    return temList;
  }

  List child;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  //Manually operated Carousel
  CarouselSlider manualCarouselDemo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subcriptionList = addList();
    child = map<Widget>(
      subcriptionList,
      (index, item) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Column(children: <Widget>[
              Container(
                color: Colors.orange,
                width: 400,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(item.title),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: "\$ ",
                            children: <TextSpan>[
                          TextSpan(
                              text: item.pricing,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "/" + item.unit,
                              style: TextStyle(color: Colors.black))
                        ]))
                  ],
                ),
              ),
              Container(
                width: 400,
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service 1"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service 2"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service 3"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service 4"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service 5"),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: double.infinity, minHeight: 45.0),
                      child: RaisedButton(
                          child: new Text("Subscribe"),
                          onPressed: () {},
                          textColor: Colors.white,
                          color: Color(0xff170e50),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)))),
                ),
              ),
            ]),
          ),
        );
      },
    ).toList();

    manualCarouselDemo = CarouselSlider(
      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.8,
      aspectRatio: 1.0,
      initialPage: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: AnimatedBackground()),
            onBottom(AnimatedWave(
              height: 180,
              speed: 1.0,
            )),
            onBottom(AnimatedWave(
              height: 120,
              speed: 0.9,
              offset: pi,
            )),
            onBottom(AnimatedWave(
              height: 220,
              speed: 1.2,
              offset: pi / 2,
            )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(children: [
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                        color: Colors.grey,
                      ),
                      Text(
                        "Subscription Plans",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Expanded(
                    child: (child.length > 0)
                        ? manualCarouselDemo
                        : SizedBox(
                            height: 10,
                          ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
