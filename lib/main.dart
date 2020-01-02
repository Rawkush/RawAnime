import 'package:flutter/material.dart';
import 'package:myapp/Provider/home_provider.dart';
import 'package:myapp/Screen/dashBoard.dart';
import 'package:myapp/Screen/detail_page.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: DashBoard(),
        routes: {
          "/detailPage": (context) => DetailPage(),
        },
      ),
    );
  }
}
