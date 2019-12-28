import 'package:flutter/material.dart';
import 'package:myapp/Provider/home_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;

    final _homeProvider = Provider.of<HomeProvider>(context);
    final _currentitem = _homeProvider.getElementWithId(_id);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black87,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text(_currentitem.title),
      // ),
      body: Column(
        children: <Widget>[
          Container(
            height: _height * 0.37,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  height: _height * 0.3,
                  width: _width,
                  constraints:
                      BoxConstraints(maxHeight: _height > 600 ? 280 : 180),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                        image: NetworkImage(_currentitem.img),
                        fit: BoxFit.fill,
                      )),
                ),
                Positioned(
                  left: _width * 0.1,
                  right: _width * 0.1,
                  bottom: _height * 0.03,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: _height * 0.03,
                          maxHeight: 60,
                        ),
                        child: Center(
                          child: Text(
                            _currentitem.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
