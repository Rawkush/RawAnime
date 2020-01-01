import 'package:flutter/material.dart';
import 'package:myapp/Widgets/media_player.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: 
           Dialog(
            elevation: 10,
            insetAnimationDuration: Duration(milliseconds: 300),
            insetAnimationCurve: Curves.decelerate,
            child:Padding(
              padding: const EdgeInsets.all(0),
              child: Center(child: VideoPlayerScreen()),
            ),
          ),
        
      
    );
  }
}
