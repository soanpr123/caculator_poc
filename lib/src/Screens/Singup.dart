import 'package:caculatorpoc/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

import 'AnswerQuestion.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<RefreshIndicatorState> _refreshKey=new GlobalKey<RefreshIndicatorState>();
  bool ShowPass = false;
  LoginBloc _bloc = new LoginBloc();
  TextEditingController _emailControler = new TextEditingController();
  TextEditingController _passControler = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Let's start by creating your \n NerdWallet account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: _SigninGoogle(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "--------------- Or ---------------",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
                  stream: _bloc.getUser(),
                  builder: (context, snapshot) => TextField(
                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error : null,
                          hintText: 'example@gmail.com',
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
                        controller: _emailControler,
                      )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                        stream: _bloc.getPassword(),
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
                              controller: _passControler,
                            )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: onTogelShow,
                        child: ShowPass ? Icon(Icons.visibility_off):Icon(Icons.remove_red_eye),
                      ),
                    )
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10),
              child: Text(
                "8 minimum characters, 1 uppercase letter,1 numeral or special character \n \nBy tapping Create account ,  I agree to NerdWallet's Terms of User and Privacy Policy",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  color: Colors.green,
                  onPressed: gotoCreate,
                  child: Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _SigninGoogle() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        print("oke");
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/Google_Logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void gotoCreate() {
    if (_bloc.isValidaInfo(_emailControler.text, _passControler.text)) {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Answer(
          key: _refreshKey,
          email: _emailControler.text,
          password: _passControler.text,
        )));



    }
  }

  void onTogelShow() {
    setState(() {
      ShowPass = !ShowPass;
    });
  }
}
