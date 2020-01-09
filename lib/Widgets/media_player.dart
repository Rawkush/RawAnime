import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Model/episode_model.dart';
import 'package:myapp/Provider/detail_page_provider.dart';
import 'package:myapp/Widgets/episode_card.dart';
import 'package:myapp/Widgets/video_overlay.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const route = "/video_player_screen";

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  //Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;
  bool _isPortrait = true;
  bool _isStackOpen = false;
  //double _value = 0.0;
  int _currentEpisodeIndex;
  List<Episode> _episodes;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      _currentEpisodeIndex = ModalRoute.of(context).settings.arguments;
      _episodes =
          Provider.of<DetailPageProvider>(context, listen: false).episodeList;

      setState(() {});

      _initEpisode();
    });
  }

  Future<void> _initEpisode() async {
    _controller = VideoPlayerController.network(
      _episodes[_currentEpisodeIndex].episodeUrl,
    );
    await _controller.initialize();
    setState(() {});
  }

  void _changeEpisode(int flag) {
    if ((_currentEpisodeIndex == 0 && flag == -1) ||
        (_currentEpisodeIndex == _episodes.length - 1 && flag == 1)) return;

    setState(() {
      _controller = null;
    });
    _currentEpisodeIndex += flag;
    _initEpisode();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isPortrait
          ? SafeArea(
              child: Column(children: <Widget>[
                _getMediaPlayer(),
                Expanded(
                  child: Container(
                    child: Center(
                      child: _episodes == null
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: _episodes.length,
                              itemBuilder: (_, i) => Stack(children: [
                                EpisodeCard(
                                  _episodes[i],
                                  i == _currentEpisodeIndex,
                                ),
                                Divider(height: 1,),
                              ]),
                            ),
                    ),
                  ),
                ),
              ]),
            )
          : SingleChildScrollView(
              child: Column(children: <Widget>[
                _getMediaPlayer(),
                Container(
                  child: Center(
                    child: _episodes == null
                        ? CircularProgressIndicator()
                        : Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              ..._episodes
                                  .map((episode) => Stack(
                                        children: <Widget>[
                                          EpisodeCard(
                                            episode,
                                            _episodes.indexOf(episode) ==
                                                _currentEpisodeIndex,
                                          ),
                                          Divider(height: 1,),
                                        ],
                                      ))
                                  .toList()
                            ],
                          ),
                  ),
                ),
              ]),
            ),
    );
  }

  Widget _getMediaPlayer() {
    double _height, _width;
    Widget _child;

    if (_controller == null) {
      _child = Center(
        child: CircularProgressIndicator(),
      );
      if (_isPortrait) {
        _height = MediaQuery.of(context).size.height * 0.3;
        _width = MediaQuery.of(context).size.width;
      } else {
        _height = MediaQuery.of(context).size.height;
        _width = MediaQuery.of(context).size.width;
      }
    } else {
      if (_controller.value.initialized) {
        _child = _previewVideo();
        if (_isPortrait) {
          _width = MediaQuery.of(context).size.width;
          _height = _width / _controller.value.aspectRatio;
        } else {
          _height = MediaQuery.of(context).size.height;
          _width = MediaQuery.of(context).size.width;
        }
      } else {
        _child = Center(
          child: CircularProgressIndicator(),
        );
        if (_isPortrait) {
          _height = MediaQuery.of(context).size.height * 0.3;
          _width = MediaQuery.of(context).size.width;
        } else {
          _height = MediaQuery.of(context).size.height;
          _width = MediaQuery.of(context).size.width;
        }
      }
    }

    return Container(
      height: _height,
      width: _width,
      child: Center(child: _child),
      color: Colors.black,
    );
  }

  Widget _previewVideo() {
    double _height, _width;
    if (_isPortrait) {
      _width = MediaQuery.of(context).size.width;
      _height = _width / _controller.value.aspectRatio;
    } else {
      _height = MediaQuery.of(context).size.height;
      _width = _height * _controller.value.aspectRatio;
    }

    if (_controller == null) {
      isPlaying = false;
      return const Text('Please Select or Record a Video.');
    } else if (_controller.value.initialized) {
      return Container(
        width: _width,
        height: _height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: InkWell(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(
                      _controller,
                    ),
                  ),
                  onTap: _toggleOverlay,
                  onDoubleTap: () {
                    if (isPlaying) {
                      _controller.pause();
                      isPlaying = false;
                    } else {
                      _controller.play();
                      isPlaying = true;
                    }
                  }),
            ),
            _isStackOpen
                ? Container()
                : VideoOverlay(
                    _controller,
                    _isPortrait,
                    _toggleOverlay,
                    _toggleOrientation,
                    _changeEpisode,
                  ),
          ],
        ),
      );
    } else {
      isPlaying = false;
      return const Text('Error Loading Video');
    }
  }

  void _toggleOverlay() {
    setState(() {
      _isStackOpen = !_isStackOpen;
    });
  }

  void _toggleOrientation() {
    if (_isPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);

      setState(() {
        _isPortrait = false;
      });
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      setState(() {
        _isPortrait = true;
      });
    }
  }
}
