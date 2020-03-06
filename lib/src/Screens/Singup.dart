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
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Let's start by creating your \n NerdWallet account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
               padding: EdgeInsets.only(top: 25),
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
                padding: const EdgeInsets.only(top:20.0),
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
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "8 minimum characters, 1 uppercase letter,1 numeral or special character  \nBy tapping Create account ,  I agree to NerdWallet's Terms of User and Privacy Policy",
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
