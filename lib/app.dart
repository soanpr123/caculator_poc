import 'package:caculatorpoc/src/Screens/Login.dart';
import 'package:caculatorpoc/src/Screens/Splap.dart';
import 'package:caculatorpoc/src/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MyApp extends StatefulWidget {

  @override
 MyappState createState()=>MyappState();
}
class MyappState extends State<MyApp> {
  bool isLogin=false;
  final _storage = new FlutterSecureStorage();

  void read() async {
    String email = await _storage.read(key: "emailed");
    String pass = await _storage.read(key: "passed");
    print("valuesss= $email");
    print("valuesss = $pass");
    if(email!=null&&pass!=null){
      setState(() {
        isLogin=true;
        Fluttertoast.showToast(
            msg: "login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
return;
    }
  }
  @override
  void initState() {
    super.initState();
    read();
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      home: isLogin ? Home() : Spalp(),
    );
  }


}

