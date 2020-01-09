import 'package:flutter/material.dart';
import 'package:myapp/Provider/detail_page_provider.dart';
import 'package:myapp/Widgets/media_player.dart';
import 'package:provider/provider.dart';

class EpisodeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final _episodeList = Provider.of<DetailPageProvider>(context, listen: false).episodeList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
      child: GridView.builder(
          itemCount: _episodeList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            childAspectRatio: 2 / 2,
            mainAxisSpacing: 11,
            crossAxisSpacing: 11,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      _episodeList[index].episodeNumber,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(color: Colors.white),
                    ),
                  )),
              onTap: () {
                Navigator.of(context).pushNamed(
                  VideoPlayerScreen.route,
                  arguments: index,
                );
              },
            );
          }),
    );
  }
}
