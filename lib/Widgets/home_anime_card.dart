import 'package:flutter/material.dart';
import 'package:myapp/Model/home_model.dart';

class HomeAnimeCard extends StatelessWidget {
  final HomeModel _homeModel;
  HomeAnimeCard(this._homeModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
              onTap: (){
                print(_homeModel.id);
                Navigator.of(context).pushNamed('/detailPage',arguments: _homeModel.id);
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
                              _homeModel.img,
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
                              _homeModel.title.toString(),
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
  }
}