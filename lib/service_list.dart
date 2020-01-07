import 'package:eleve11/modal/service.dart';
import 'package:eleve11/service_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  _ServiceList createState() => _ServiceList();
}

class _ServiceList extends State<ServiceList> {
  List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Service service) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.directions_car, color: Colors.white),
          ),
          title: Text(
            service.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: 4,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("4", style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ServiceDetailPage(service)));
          },
        );

    Card makeCard(Service service) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(service),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }
}

List getLessons() {
  return [
    Service(
        bannerUrl: 'assets/imgs/banner.jpg',
        posterUrl: 'assets/imgs/poster.jpg',
        title: 'Interior and Upholstery Cleaning',
        rating: 8.0,
        starRating: 4,
        categories: ['Cleaning', 'Disinfection'],
        storyline: 'For their fifth fully-animated feature-film '
            'collaboration, Illumination Entertainment and Universal '
            'Pictures present The Secret Life of Pets, a comedy about '
            'the lives our...',
        photoUrls: [
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
        ]),
    Service(
        bannerUrl: 'assets/imgs/banner.jpg',
        posterUrl: 'assets/imgs/poster.jpg',
        title: 'Paint Restoration Polish',
        rating: 8.0,
        starRating: 4,
        categories: ['High gloss', 'Finishing'],
        storyline: 'For their fifth fully-animated feature-film '
            'collaboration, Illumination Entertainment and Universal '
            'Pictures present The Secret Life of Pets, a comedy about '
            'the lives our...',
        photoUrls: [
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
        ]),
    Service(
        bannerUrl: 'assets/imgs/banner.jpg',
        posterUrl: 'assets/imgs/poster.jpg',
        title: 'Wax Polish',
        rating: 8.0,
        starRating: 4,
        categories: ['Economical', 'Polish Shine'],
        storyline: 'For their fifth fully-animated feature-film '
            'collaboration, Illumination Entertainment and Universal '
            'Pictures present The Secret Life of Pets, a comedy about '
            'the lives our...',
        photoUrls: [
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
        ]),
    Service(
        bannerUrl: 'assets/imgs/banner.jpg',
        posterUrl: 'assets/imgs/poster.jpg',
        title: 'Underbody Antirust Treatment',
        rating: 8.0,
        starRating: 4,
        categories: ['Long term protection', 'Disinfection'],
        storyline: 'For their fifth fully-animated feature-film '
            'collaboration, Illumination Entertainment and Universal '
            'Pictures present The Secret Life of Pets, a comedy about '
            'the lives our...',
        photoUrls: [
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
        ]),
    Service(
        bannerUrl: 'assets/imgs/banner.jpg',
        posterUrl: 'assets/imgs/poster.jpg',
        title: 'AC Disinfection Treatment',
        rating: 8.0,
        starRating: 4,
        categories: ['Ac interior vents', 'Cooling coil and blower disinfection'],
        storyline: 'For their fifth fully-animated feature-film '
            'collaboration, Illumination Entertainment and Universal '
            'Pictures present The Secret Life of Pets, a comedy about '
            'the lives our...',
        photoUrls: [
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
          'assets/imgs/photo1.png',
          'assets/imgs/poster2.jpg',
        ])
  ];
}
