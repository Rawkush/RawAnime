import 'package:flutter/material.dart';

class EoisodeList{
  static Widget myEpisodeList(int _itemCount){
     return Container(
       child: Expanded(
         child:ListView.builder(
           itemCount: 1,
           itemBuilder: (BuildContext context, int index) {
           return ;
          },
         ),
       ),
     );
  }
}