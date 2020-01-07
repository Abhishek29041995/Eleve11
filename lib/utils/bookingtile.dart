
import 'package:eleve11/modal/booking_item.dart';
import 'package:flutter/material.dart';

class BookingTile extends AnimatedWidget {
  BookingTile({
    Key key,
    Animation<double> animation,
    this.bookingItem,
    this.onAction,
    this.isHeader: false,
    this.delay: 200,
  }):super(key: key, listenable: animation);

  final BookingItem bookingItem;
  final VoidCallback onAction;
  final bool isHeader;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _height,
      child: Stack(
        children: <Widget>[
          _makeInfo(context),
          _makeBeer(context),
        ],
      ),
    );
  }

  _makeBeer(BuildContext context){
    final Animation<double> animation = listenable;
    final double _width = MediaQuery.of(context).size.width;

    Tween<double> tween = Tween(begin: _width - 90, end: 0.0);

    return new Positioned(
      top: isHeader ? 0.0 : 10.0,
      bottom: 0.0,
      right: isHeader ? 0.0 : tween.evaluate(animation),
      width: _width,
      child: Hero(
        tag: bookingItem.image,
        child: new Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: (){
              if(!isHeader){
                onAction == null ? null : onAction();
              }
            },
            child: Stack(
              children: <Widget>[
                new Positioned(
                  top: isHeader ? 0.0 : 10.0,
                  bottom: isHeader ? 0.0 : 10.0,
                  left: 0.0,
                  right: isHeader ? 0.0 : 20.0,
                  child: new Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: bookingItem.color,
                    child: Text(
                      bookingItem.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.w300,
                        fontSize: 35.0,
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(
                      bottom: 30.0,
                      left: 15.0,
                      right: 65.0,
                    ),
                  ),
                ),
                new Positioned(
                  top: isHeader ? 45.0 : 0.0,
                  bottom: isHeader ? -20.0 : 0.0,
                  left: isHeader ? _width - 40 : _width - 62,
                  width: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(bookingItem.asset),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _makeInfo(BuildContext context) {
    return isHeader ? Container() : Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 110.0,
      right: 20.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(bookingItem.title, style: Theme.of(context).textTheme.headline.copyWith(color: bookingItem.color),),
          ),
          Text(bookingItem.size, style: Theme.of(context).textTheme.body1,),
          Text('From \$48.00', style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w500),),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.0),
            width: double.infinity,
            child: FlatButton(
              color: Colors.grey.shade300,
              onPressed: (){},
              child: Text('Order'),
            ),
          ),
        ],
      ),
    );
  }

  double get _height {
    if(isHeader) {
      return 275.0;
    } else {
      return 200.0;
    }
  }
}