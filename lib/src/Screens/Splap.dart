import 'package:caculatorpoc/src/Screens/Login.dart';
import 'package:caculatorpoc/src/Screens/Singup.dart';
import 'package:caculatorpoc/src/resources/slide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Spalp extends StatefulWidget {
  @override
  _Splap createState() => _Splap();
}

class _Splap extends State<Spalp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 16.0),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Image.asset(
                "assets/images/logo.jpg",
                width: 300,
                height: 120,
              ),
            ),
            SizedBox(
              height: 300,
              child: CarouselWithIndicator(),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    color: Colors.green,
                    onPressed: goTosignUp,
                    child: Text("SIGNUP"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.blue, fontSize: 15.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      " Sign in",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void goTosignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}
