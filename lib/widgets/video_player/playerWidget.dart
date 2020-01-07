import 'dart:async';

import 'package:eleve11/widgets/video_player/fullscreen_player.dart';
import 'package:eleve11/widgets/video_player/player.dart';
import 'package:eleve11/widgets/video_player/player_options.dart';
import 'package:eleve11/widgets/video_player/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_controller_widgets.dart';
import 'video_controller_wrapper.dart';

///core video player
class PlayerWidget extends StatefulWidget {
  final VideoControllerWrapper videoControllerWrapper;

  final PlayerOptions playerOptions;

  /// Defines the width of the player.
  /// Default = Devices's Width
  final double width;

  ///The duration for which controls in the player will be visible.
  ///default 3 seconds
  final Duration controllerTimeout;

  /// Overrides the default buffering indicator for the player.
  final Widget bufferIndicator;

  final Color liveUIColor;

  /// Defines the aspect ratio to be assigned to the player. This property along with [width] calculates the player size.
  /// Default = 16/9
  final double aspectRatio;

  /// Adds custom top bar widgets
  final List<Widget> actions;

  /// Video starts playing from the duration provided.
  final Duration startAt;

  final bool inFullScreen;

  /// Callback of back-button's onTap event  when the top controller is portrait
  final Function onPortraitBackTap;

  /// When the skip previous button tapped
  final Function onSkipPrevious;

  /// When the skip previous button tapped
  final Function onSkipNext;

  final Color progressBarPlayedColor;
  final Color progressBarBufferedColor;
  final Color progressBarHandleColor;
  final Color progressBarBackgroundColor;

  PlayerWidget(
      {Key key,
        @required this.videoControllerWrapper,
        this.playerOptions = const PlayerOptions(),
        this.controllerTimeout = const Duration(seconds: 3),
        this.bufferIndicator,
        this.liveUIColor = Colors.red,
        this.aspectRatio = 16 / 9,
        this.width,
        this.actions,
        this.startAt = const Duration(seconds: 0),
        this.inFullScreen = false,
        this.onPortraitBackTap,
        this.onSkipPrevious,
        this.onSkipNext,
        this.progressBarPlayedColor,
        this.progressBarBufferedColor: const Color(0xFF757575),
        this.progressBarHandleColor,
        this.progressBarBackgroundColor: const Color(0xFFF5F5F5)})
      : assert(videoControllerWrapper != null),
        assert(playerOptions != null),
        super(key: key);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final _showControllers = ValueNotifier<bool>(true);

  Timer _timer;

  VideoPlayerController get controller =>
      widget.videoControllerWrapper.controller;

  VideoControllerWrapper get videoControllerWrapper =>
      widget.videoControllerWrapper;

  @override
  void initState() {
    super.initState();
    _loadController();

    _addShowControllerListener();
    _listenVideoControllerWrapper();
    _configureVideoPlayer();
  }

  void _listenVideoControllerWrapper() {
    videoControllerWrapper.addListener(() {
      if (mounted)
        setState(() {
//          _addShowControllerListener();
//          _autoPlay();
        });
    });
  }

  void _addShowControllerListener() {
    _showControllers.addListener(() {
      _timer?.cancel();
      if (_showControllers.value) {
        _timer = Timer(
          widget.controllerTimeout,
              () => _showControllers.value = false,
        );
      }
    });
  }

  void _loadController() {
//    controller = widget.videoPlayerController;
//    controller.isFullScreen = widget.inFullScreen ?? false;
//    controller.addListener(_listener);

    if (controller == null || !controller.value.initialized) {
      _showControllers.value = true;
    }
  }

  _configureVideoPlayer() {
    if (widget.playerOptions.autoPlay) {
      _autoPlay();
    }

//    widget.videoPlayerController.setLooping(widget.playerOptions.loop);
  }

  _autoPlay() async {
    if (controller == null) {
      return;
    }

    if (controller.value.isPlaying) {
      return;
    }
    if (controller.value.initialized) {
      if (widget.startAt != null) {
        await controller.seekTo(widget.startAt);
      }
      controller.play();
    }
  }

  @override
  void dispose() {
//    if (widget.playerOptions.autoPlay) {
//      controller.dispose();
//    }

//    _showControllers.dispose();
    controller?.dispose();
    videoControllerWrapper?.dispose();
    _timer?.cancel();
    super.dispose();
  }

//  Widget fullScreenRoutePageBuilder(
//      BuildContext context,
//      Animation<double> animation,
//      Animation<double> secondaryAnimation,
//      ) {
//    return _buildFullScreenVideo();
//  }

  void pushFullScreenWidget() {
    final TransitionRoute<void> route = PageRouteBuilder<void>(
      settings: RouteSettings(name: "pavel", isInitialRoute: false),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
          fullScreenRoutePageBuilder(
            context: context,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            videoControllerWrapper: widget.videoControllerWrapper,
            width: widget.width,
            actions: widget.actions,
            aspectRatio: widget.aspectRatio,
            bufferIndicator: widget.bufferIndicator,
            onSkipPrevious: widget.onSkipPrevious,
            onSkipNext: widget.onSkipNext,
            controllerTimeout: widget.controllerTimeout,
            playerOptions: PlayerOptions(
                enableDragSeek: widget.playerOptions.enableDragSeek,
                showFullScreenButton: widget.playerOptions.showFullScreenButton,
                autoPlay: true,
                useController: widget.playerOptions.useController,
                isLive: widget.playerOptions.isLive,
                preferredOrientationsWhenEnterLandscape:
                widget.playerOptions.preferredOrientationsWhenEnterLandscape,
                preferredOrientationsWhenExitLandscape:
                widget.playerOptions.preferredOrientationsWhenExitLandscape,
                enabledSystemUIOverlaysWhenEnterLandscape:
                widget.playerOptions.enabledSystemUIOverlaysWhenEnterLandscape,
                enabledSystemUIOverlaysWhenExitLandscape:
                widget.playerOptions.enabledSystemUIOverlaysWhenExitLandscape),
            liveUIColor: widget.liveUIColor,
          ),
    );

    route.completed.then((void value) {
//      controller.setVolume(0.0);
    });

//    controller.setVolume(1.0);
    Navigator.of(context).push(route).then((_) {
      if (mounted)
        setState(() {
          _listenVideoControllerWrapper();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
//    if (controller.isFullScreen == null) {
//      controller.isFullScreen =
//          MediaQuery.of(context).orientation == Orientation.landscape;
//    }

    return Hero(
      tag: "pavel",
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: <Widget>[
              Player(controllerWrapper: videoControllerWrapper),
              if (widget.playerOptions.useController)
                TouchShutter(
                  videoControllerWrapper,
                  showControllers: _showControllers,
                  enableDragSeek: widget.playerOptions.enableDragSeek,
                ),
              if (widget.playerOptions.useController)
                Center(
                  child: CenterControllerActionButtons(
                    videoControllerWrapper,
                    showControllers: _showControllers,
                    isLive: widget.playerOptions.isLive,
                    onSkipPrevious: widget.onSkipPrevious,
                    onSkipNext: widget.onSkipNext,
                    bufferIndicator: widget.bufferIndicator ??
                        Container(
                          width: 70.0,
                          height: 70.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                  ),
                ),
              if (widget.playerOptions.useController)
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: TopBar(
                      videoControllerWrapper,
                      showControllers: _showControllers,
                      options: widget.playerOptions,
                      actions: widget.actions,
                      isFullscreen: false,
                      onPortraitBackTap: widget.onPortraitBackTap,
                    )),
              if (widget.playerOptions.useController)
                (!widget.playerOptions.isLive)
                    ? Positioned(
                  left: 0,
                  right: 0,
                  child: ProgressBar(
                    videoControllerWrapper,
                    showControllers: _showControllers,
                    playedColor: widget.progressBarPlayedColor,
                    handleColor: widget.progressBarHandleColor,
                    backgroundColor: widget.progressBarBackgroundColor,
                    bufferedColor: widget.progressBarBufferedColor,
                  ),
                  bottom: -27.9,
                )
                    : Container(),
              if (widget.playerOptions.useController)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: widget.playerOptions.isLive
                      ? LiveBottomBar(
                    videoControllerWrapper,
                    aspectRatio: widget.aspectRatio,
                    liveUIColor: widget.liveUIColor,
                    showControllers: _showControllers,
                    playedColor: widget.progressBarPlayedColor,
                    handleColor: widget.progressBarHandleColor,
                    backgroundColor: widget.progressBarBackgroundColor,
                    bufferedColor: widget.progressBarBufferedColor,
                    isFullscreen: false,
                    onEnterFullscreen: pushFullScreenWidget,
                  )
                      : BottomBar(
                    videoControllerWrapper,
                    aspectRatio: widget.aspectRatio,
                    showControllers: _showControllers,
                    playedColor: widget.progressBarPlayedColor,
                    handleColor: widget.progressBarHandleColor,
                    backgroundColor: widget.progressBarBackgroundColor,
                    bufferedColor: widget.progressBarBufferedColor,
                    isFullscreen: false,
                    onEnterFullscreen: pushFullScreenWidget,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}