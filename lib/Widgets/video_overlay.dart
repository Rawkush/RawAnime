import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoOverlay extends StatefulWidget {
  final Function _changeEpisode;
  final Function _toggleOrientation;
  final VideoPlayerController _controller;
  final Function _toggleOverlayVisibility;
  final bool _isPortrait;

  VideoOverlay(this._controller, this._isPortrait,
      this._toggleOverlayVisibility, this._toggleOrientation, this._changeEpisode);

  @override
  _VideoOverlayState createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<VideoOverlay> {
  double _value;

  void _controllerListener() {
    setState(() {
      _value = widget._controller.value.position.inSeconds.toDouble();
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget._controller.value.position.inSeconds.toDouble();
    widget._controller.addListener(_controllerListener);
  }

  @override
  void deactivate() {
    super.deactivate();
    if (widget._controller != null)
      widget._controller.removeListener(_controllerListener);
  }

  String _durationToShow(Duration duration) {
    int totalSeconds = duration.inSeconds;
    int hoursToShow = totalSeconds ~/ 3600;
    int minutesToShow = (totalSeconds % 3600) ~/ 60;
    int secondsToShow = (totalSeconds % 3600) % 60;
    String h = hoursToShow == 0
        ? ""
        : hoursToShow <= 9
            ? "0" + hoursToShow.toString()
            : hoursToShow.toString();
    String m = minutesToShow == 0
        ? hoursToShow > 0 ? "00" : "0"
        : minutesToShow <= 9
            ? "0" + minutesToShow.toString()
            : minutesToShow.toString();
    String s = secondsToShow == 0
        ? "00"
        : secondsToShow <= 9
            ? "0" + secondsToShow.toString()
            : secondsToShow.toString();
    
    return h.isEmpty ? (m + ":" + s): (h + ":" + m + ":" + s);
  }

  @override
  Widget build(BuildContext context) {
    double _height, _width;
    if(widget._isPortrait){
      _width = MediaQuery.of(context).size.width;
      _height = _width / widget._controller.value.aspectRatio;
    }else{
      _height = MediaQuery.of(context).size.height;
      _width = _height * widget._controller.value.aspectRatio;
    }
    
    return GestureDetector(
      onTap: widget._toggleOverlayVisibility,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black54, shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_left,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget._changeEpisode(-1);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        widget._controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (widget._controller.value.isPlaying) {
                            widget._controller.pause();
                          } else {
                            widget._controller.play();
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black54, shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget._changeEpisode(1);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: _width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: _width - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Text(
                              _durationToShow(
                                  widget._controller.value.position),
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              _durationToShow(widget._controller.value.duration),
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        widget._isPortrait
                            ? Icons.fullscreen
                            : Icons.fullscreen_exit,
                        size: 33,
                        color: Colors.white,
                      ),
                      onTap: widget._toggleOrientation,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 15,
              child: SizedBox(
                width: _width,
                child: Slider(
                  onChanged: (double changedValue) {
                    setState(() {
                      _value = changedValue;
                      widget._controller
                          .seekTo(Duration(seconds: changedValue.floor()));
                    });
                  },
                  onChangeStart: (changedValue) {
                    setState(() {
                      _value = changedValue;
                    });
                  },
                  value: _value,
                  min: 0.0,
                  max: widget._controller.value.duration.inSeconds.toDouble(),
                  label: _value.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
