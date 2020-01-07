import 'package:eleve11/modal/order_list.dart';
import 'package:eleve11/subscription.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  List<Widget> sample = new List();
  List<OrderList> serviceList = new List();

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Offers",
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
    var subscription = Positioned(
      right: 0,
      top: 56,
      child: Card(
        color: Color(0xff170e50),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new SubscriptionPlans()));
            },
            child: Text(
              "Subscribe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
    list.add(subscription);
    var servicelist = Padding(
      padding: EdgeInsets.only(top: 80),
      child: ListView.separated(
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
          itemCount: serviceList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          color: Color(0xFFFFD180)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              serviceList[index].companyicon,
                              width: 48,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              serviceList[index].couponcode,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      serviceList[index].offerTitle,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(
                      serviceList[index].offerDesc,
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ));
          }),
    );
    list.add(servicelist);
    return list;
  }

  List<OrderList> getServices() {
    return [
      OrderList(
          "100SBI",
          "assets/sbi_card_logo.png",
          "Get 20% discount using SBI Credit Card",
          "Use code 100SBI and get 20 % discount up to \$ 100 on orders above \$400",
          [
            "Offer valid only on SBI credit card",
            "Offer valid on only Monday & Tuesday",
            "Offer valid till Dec 31, 2019 23:59 PM"
          ]),
      OrderList(
          "PAYZAPP125",
          "assets/hdfc.png",
          "Get 30% discount using SBI Credit Card",
          "Use code PAYZAPP125 and get 30 % discount up to \$ 125 on orders \$199 and above",
          [
            "Offer valid only on SBI credit card",
            "Offer valid on only Monday & Tuesday",
            "Offer valid till Dec 31, 2019 23:59 PM"
          ]),
      OrderList(
          "FCH30",
          "assets/fch.png",
          "Get 20% discount using SBI Credit Card",
          "Use code FCH30 and get 20 % discount up to \$ 125 on orders \$199 and above",
          [
            "Offer valid only on SBI credit card",
            "Offer valid on only Monday & Tuesday",
            "Offer valid till Dec 31, 2019 23:59 PM"
          ]),
      OrderList(
          "HSBC20",
          "assets/hsbc.png",
          "Get 30% discount using SBI Credit Card",
          "Use code HSBC20 and get 30 % discount up to \$ 125 on orders \$199 and above",
          [
            "Offer valid only on SBI credit card",
            "Offer valid on only Monday & Tuesday",
            "Offer valid till Dec 31, 2019 23:59 PM"
          ]),
    ];
  }
}
