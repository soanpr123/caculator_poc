import 'package:caculatorpoc/src/Screens/Splap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class MyApp extends StatefulWidget {

  @override
 MyappState createState()=>MyappState();
}
class MyappState extends State<MyApp> {
  String emails = "";
  String passs = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Spalp(),
    );
  }

  }

