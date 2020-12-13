import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/bookmark.dart';
import 'package:myapp/Screen/home.dart';
import 'package:myapp/Screen/search.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

enum PopupMenuEntry{
  LatestEpisodes,
  Popular
}

class _DashBoardState extends State<DashBoard> {
  int _bottomSelectedIndex = 1;
  PageController _pageController;
  List<String> _categoryList = ["BookMarks", "Home", "Search"];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _bottomSelectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryList[_bottomSelectedIndex]),
      ),
      body: PageView(
        //physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
        controller: _pageController,
        children: <Widget>[
          BookMark(),
          Home(),
          Search(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.orange,
        color: Colors.blue,
        buttonBackgroundColor: Colors.white,
        height: 55,
        index: _bottomSelectedIndex,
        items: <Widget>[
          Icon(Icons.bookmark, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 100),
                curve: Curves.decelerate);
          });
        },
      ),
    );
  }
}
