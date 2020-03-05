import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Caculator extends StatefulWidget {
  @override
  CaculatorState createState() => CaculatorState();
}

class CaculatorState extends State<Caculator> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Retirement caculator",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 16.0),
                child: Text(
                  "Tell us a few things abuot yourself, and this caculator will show whether you're on track for the retirement you want",
                  style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal),
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
