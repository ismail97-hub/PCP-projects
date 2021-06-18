import 'package:PCP/FisrtPage.dart';
import 'package:PCP/SelectionerType.dart';
import 'package:PCP/VideoPage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FirstPage(),
    );
  }
}   
