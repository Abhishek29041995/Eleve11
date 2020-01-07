import 'package:eleve11/modal/booking_item.dart';
import 'package:eleve11/utils/bookingtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingHistoryDetail extends StatefulWidget {
  final BookingItem bookingItem;
  final CurvedAnimation animation;
  final VoidCallback onAction;

  BookingHistoryDetail({this.bookingItem, this.animation, this.onAction});

  @override
  _BookingHistoryDetailState createState() => new _BookingHistoryDetailState();
}

class _BookingHistoryDetailState extends State<BookingHistoryDetail> {
  bool _visible = false;

  @override
  void initState() {
    if(widget.bookingItem.isDark){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    Future.delayed(Duration(milliseconds: 250)).then((v){
      setState(() {
        _visible = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookingItem bookingItem = widget.bookingItem;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              BookingTile(
                isHeader: true,
                bookingItem: bookingItem,
                animation: widget.animation,
                onAction: widget.onAction,
              ),
              new Expanded(
                child: SingleChildScrollView(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Tasting Note',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: bookingItem.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                        child: Text(bookingItem.note,),
                      ),
                      Divider(height: 10.0, indent: 35.0,),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Word from the Maker',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.body2,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                        child: Text(bookingItem.word,),
                      ),
                      Container(
                        color: bookingItem.color.withAlpha(120),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
                              child: Text(
                                'Food Matches',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.body2.copyWith(
                                    color: bookingItem.isDark ? Colors.white : Colors.black
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                              child: Text(bookingItem.foodMatch,
                                style: TextStyle(
                                    color: bookingItem.isDark ? Colors.white : Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(bookingItem.size, style: Theme.of(context).textTheme.body1,),
                            Text('From \$48.00', style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: FlatButton(
                    color: Colors.grey.shade300,
                    onPressed: (){},
                    child: Text('Order'),
                  ),
                ),
              ),
            ],
          ),
          new AnimatedPositioned(
            top: _visible ? 35.0 : 0.0,
            left: 10.0,
            height: 60.0,
            width: 50.0,
            duration: Duration(milliseconds: 150),
            curve: Curves.bounceInOut,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
              opacity: _visible ? 1.0 : 0.0,
              child: IconButton(
                icon: Icon(Icons.clear),
                color: Colors.white,
                onPressed: (){
                  setState(() {
                    _visible = false;
                  });
                  widget.onAction != null ? widget.onAction() : null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}