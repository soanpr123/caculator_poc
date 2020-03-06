import 'package:caculatorpoc/src/bloc/login_bloc.dart';
import 'package:caculatorpoc/src/dialog/Loading.dart';
import 'package:caculatorpoc/src/dialog/msg_dialog.dart';
import 'package:caculatorpoc/src/resources/model/Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'FogotPass.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginStatePage createState() => _LoginStatePage();
}

class _LoginStatePage extends State<LoginPage> {
  final databaseReference = Firestore.instance;
  String emails;
  final _keymail = "email";
  final _keypas = "pass";
  bool ShowPass = false;
  final _storage = new FlutterSecureStorage();
  LoginBloc bloc = new LoginBloc();
  bool savepass = false;
  bool isLoggedIn = false;
  String name="";
  String Password="";
  TextEditingController _userC = new TextEditingController();
  TextEditingController _passC = new TextEditingController();
  void _onRememberMeChanged(bool newValue) => setState(()  {
        savepass = newValue;
        if (savepass) {
          Save();
          return newValue=true;
        } else {
         delete();
         return newValue=false;
        }
        return false;
      });
  Future Save() async {
    _storage.write(key: _keymail, value: _userC.text);
    _storage.write(key: _keypas, value: _passC.text);
return true;
  }

  Future read() async {
    String email = await _storage.read(key: _keymail);
    String pass = await _storage.read(key: _keypas);
    print("value = $email");
    print("value = $pass");
    _userC.text = email;
    _passC.text = pass;
  }
  Future delete() async {
    await _storage.delete(key: _keymail);
    await _storage.delete(key: _keypas);
return false;
  }
//
  @override
  void initState() {
    super.initState();
    print("innitstate");
    read();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.only(left: 16.0,right: 16.0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
                  stream: bloc.getUser(),
                  builder: (context, snapshot) => TextField(

                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error : null,
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),

                        controller: _userC,
                      )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                        stream: bloc.getPassword(),
                        builder: (context, snapshot) => TextField(
                              obscureText: !ShowPass,
                              decoration: InputDecoration(
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                hintText: 'PassWord',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                              ),
                              controller: _passC,
                            )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: onTogelShow,
                        child: ShowPass
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.remove_red_eye),
                      ),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(value: savepass,

                      onChanged: _onRememberMeChanged),
                  Text(
                    "Save password",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  color: Colors.green,
                  onPressed: isLoggedIn?null : Onsignclick,
                  child: Text("SIGN"),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FogotPass()));
                    },
                    child: Text(
                      "Forget your passWord?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void Onsignclick() {
    if (bloc.isValidaInfo(_userC.text, _passC.text)) {
      LoadingDialog.showLoadingDialog(context, "Loading.....");
      bloc.Sign(_userC.text, _passC.text, () async {
        _storage.write(key: "emailed", value: _userC.text);
        _storage.write(key: "passed", value: _passC.text);
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Error", msg);
      });
    }
  }

  void onTogelShow() {
    setState(() {
      ShowPass = !ShowPass;
    });
  }
}
