import 'package:flutter/material.dart';
import 'package:myapp/Provider/home_provider.dart';
import 'package:myapp/Widgets/fade.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: _height,
        width: _width,
        decoration: BoxDecoration(color: Colors.black87),
        child: GridView.builder(
          itemCount: _homeProvider.homeList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 190,
            childAspectRatio: 2 / 2.78,
            mainAxisSpacing: 11,
            crossAxisSpacing: 11,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                print(_homeProvider.homeList[index].id);
                Navigator.of(context).pushNamed('/detailPage',arguments: _homeProvider.homeList[index].id);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: SizedBox.expand(
                            child: Image.network(
                              _homeProvider.homeList[index].img,
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                    Flexible(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              _homeProvider.homeList[index].title.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
