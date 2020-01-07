import 'package:eleve11/widgets/video_player/playerWidget.dart';
import 'package:eleve11/widgets/video_player/video_controller_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  static const String beeUri =
      'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4';

  final VideoControllerWrapper videoControllerWrapper = VideoControllerWrapper(
      DataSource.network(
          'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4'));
//  @override
//  void initState() {
//    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
//  }
//
//  @override
//  void dispose() {
//    SystemChrome.restoreSystemUIOverlays();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PlayerWidget(
//        onSkipPrevious: () {
//          print("skip");
//          videoControllerWrapper.prepareDataSource(DataSource.network(
//              "http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4"));
//        },
//        onSkipNext: () {
//          videoControllerWrapper.prepareDataSource(DataSource.network(
//              'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4'));
//        },
        videoControllerWrapper: videoControllerWrapper,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                print("share");
              })
        ],
      ),
    );
  }
}
