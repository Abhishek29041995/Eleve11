import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_controller_wrapper.dart';

class Player extends StatefulWidget {
  final VideoControllerWrapper controllerWrapper;

  const Player({Key key, this.controllerWrapper}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with WidgetsBindingObserver {
//  set controllerWrapper(VideoControllerWrapper controllerWrapper) =>
//      _controllerWrapper = controllerWrapper;

//  bool _pausedByUser = false;

  @override
  Widget build(BuildContext context) {
    return widget.controllerWrapper.controller == null
        ? Container()
        : VideoPlayer(widget.controllerWrapper.controller);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}