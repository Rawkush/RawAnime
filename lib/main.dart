import 'package:flutter/material.dart';
import 'package:myapp/Provider/detail_page_provider.dart';
import 'package:myapp/Provider/home_provider.dart';
import 'package:myapp/Screen/detail_page.dart';
import 'package:provider/provider.dart';

import 'Widgets/media_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
        ChangeNotifierProvider.value(value: DetailPageProvider(),)
      ],
      child:MaterialApp(
        theme: ThemeData( 
        ),
        //home: DashBoard(),
       home: VideoPlayerScreen(),
       

       routes: {
         "/detailPage":(context)=> DetailPage(),
       },
      ),
    );
  }
}
