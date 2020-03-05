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
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 650,
                child: CarouselWithIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    color: Colors.green,
                    onPressed:goTosignUp,
                    child: Text("SIGNUP"),
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                      child: Text(
                        " Sign in",
                        style: TextStyle(color: Colors.blue, fontSize: 15.0,fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
              ),
               ),
            ],
          )),
    );
  }

 void goTosignUp() {

      Navigator.push(context, MaterialPageRoute(builder:  (context)=>SignUp()));


  }
}
