import 'package:flutter/material.dart';

class BookMark extends StatelessWidget {
  const BookMark({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height=MediaQuery.of(context).size.height;
    final _width=MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      color: Colors.black87,
    );
  }
}