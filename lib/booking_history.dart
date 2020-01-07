import 'package:eleve11/booking_history_detail.dart';
import 'package:eleve11/modal/booking_item.dart';
import 'package:eleve11/utils/bookingtile.dart';
import 'package:eleve11/utils/translations.dart';
import 'package:flutter/material.dart';

class BookingHistory extends StatefulWidget {
  BookingHistory({Key key}) : super(key: key);

  @override
  _BookingHistoryState createState() => new _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory>
    with TickerProviderStateMixin {
  Map<int, AnimationController> controllerMaps = new Map();
  Map<int, CurvedAnimation> animationMaps = new Map();

  @override
  void initState() {
    bookingItems.forEach((BookingItem bookingItem) {
      AnimationController _controller = AnimationController(
        duration: Duration(milliseconds: 400),
        vsync: this,
      );
      CurvedAnimation _animation =
          new CurvedAnimation(parent: _controller, curve: Curves.easeIn);

      controllerMaps[bookingItem.id] = _controller;
      _controller.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _handleHero(bookingItem);
        }
      });
      animationMaps[bookingItem.id] = _animation;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0.0,
        title: new Text(Translations.of(context).text('order_history')),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          BookingItem bookingItem = bookingItems[index];
          AnimationController _controller = controllerMaps[bookingItem.id];
          CurvedAnimation _animation = animationMaps[bookingItem.id];
          return BookingTile(
            bookingItem: bookingItem,
            isHeader: false,
            animation: _animation,
            onAction: () {
              _controller.forward();
            },
          );
        },
        itemCount: bookingItems.length,
      ),
    );
  }

  void _handleHero(BookingItem bookingItem) {
    AnimationController _controller = controllerMaps[bookingItem.id];
    CurvedAnimation _animation = animationMaps[bookingItem.id];
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return BookingHistoryDetail(
                    bookingItem: bookingItem,
                    animation: _animation,
                    onAction: () {
                      Navigator.pop(context);
                    },
                  );
                },
                fullscreenDialog: true))
        .then((value) {
      Future.delayed(Duration(milliseconds: 600)).then((v) {
        _controller.reverse();
      });
    });
  }
}
