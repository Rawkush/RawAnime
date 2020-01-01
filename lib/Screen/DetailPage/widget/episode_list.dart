import 'package:flutter/material.dart';
import 'package:myapp/Model/episode_model.dart';

class EpisodeList {
  static Widget myEpisodeList(List<EpisodeModel> _episodeList) {
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
              onTap: () {},
            );
          }),
    );
  }
}
