import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  VoidCallback listener;
  Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;
  bool _isPortrait = true;
  bool _isStackOpen = false;
  double _value = 0.0;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setVolume(1);
    _controller.setLooping(true);
    //_controller.addListener(_changeValue);
    _controller.addListener(()=>setState((){_value=_controller.value.position.inSeconds.toDouble();}));

    super.initState();
  }
    void _changeValue(){
    setState((){
      
     _value>_controller.value.duration.inSeconds+_controller.value.duration.inHours*60*60+_controller.value.duration.inMinutes*60? _value=_controller.value.position.inSeconds+_controller.value.position.inMinutes*60+_controller.value.position.inHours*60*60.toDouble():0.0;
      });
    }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    _orientation();
    _controller.dispose();
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }
 
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _previewVideo(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      
    );
  }

  Widget _previewVideo(VideoPlayerController controller) {
    final height = _isPortrait
        ? MediaQuery.of(context).size.height * 0.4
        : MediaQuery.of(context).size.height;
    if (controller == null) {
      isPlaying = false;
      return const Text('Please Select or Record a Video.');
    } else if (controller.value.initialized) {
      return Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: InkWell(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(
                      controller,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isStackOpen = !_isStackOpen;
                    });
                  },
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
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        _isStackOpen = !_isStackOpen;
                      });
                      
                    },
                    child: Container(
                      height: controller.value.size.height,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            
                              child: Padding(
                                padding:  EdgeInsets.only(top:MediaQuery.of(context).padding.top),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_left,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        icon: Icon(
                                          _controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (_controller.value.isPlaying) {
                                              controller.pause();
                                            } else {
                                              controller.play();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Slider(
                                  onChanged: (double changedValue) {
                                    setState(() {
                                      _value = changedValue;
                                       _controller.seekTo(Duration(seconds: changedValue.floor()));
                                    });
                                    
                                  },
                                  onChangeStart: (changedValue){
                                    setState(() {
                                      _value=changedValue;
                                    });
                                  },
                                  value: _value,
                                  min: 0.0,
                                  max: controller.value.duration.inSeconds.toDouble(),
                                  label: _value.toString(),

                                ),
                              ),
                              InkWell(
                                child: Padding(
                                  padding:  EdgeInsets.only(left:0,right: 10.0+MediaQuery.of(context).padding.bottom),
                                  child: Icon(
                                    _isPortrait
                                        ? Icons.fullscreen
                                        : Icons.fullscreen_exit,
                                    size: 33,
                                  ),
                                ),
                                onTap: () => _orientation(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      );
    } else {
      isPlaying = false;
      return const Text('Error Loading Video');
    }
  }

  void _orientation() {
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
