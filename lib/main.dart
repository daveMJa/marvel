import 'package:flutter/material.dart';
import 'package:marvel/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marvel',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
        });
  }
}
