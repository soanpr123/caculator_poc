import 'package:caculatorpoc/src/bloc/login_bloc.dart';
import 'package:caculatorpoc/src/dialog/Loading.dart';
import 'package:caculatorpoc/src/dialog/msg_dialog.dart';
import 'package:caculatorpoc/src/resources/model/Item.dart';
import 'package:flutter/material.dart';

import 'FogotScreen.dart';
import 'InforUser.dart';

class FogotPass extends StatefulWidget {
  FogotPass({Key key, this.email, this.password}) : super(key: key);
  final String email;
  final String password;
  @override
  _FogotPass createState() => _FogotPass();
}

class _FogotPass extends State<FogotPass> {
  GlobalKey<RefreshIndicatorState> _refreshKey=new GlobalKey<RefreshIndicatorState>();
  LoginBloc _bloc = new LoginBloc();
  TextEditingController answerControler = new TextEditingController();
  TextEditingController _EmailControler = new TextEditingController();
  String selectQA = "Who is your first kiss?";
  String hodelr = "";
  void getDropDownItem() {
    setState(() {
      hodelr = selectQA;
    });
  }

  List<String> _item = [
    "Who is your first kiss?",
    "Who is your dad?",
    "what hospital were u born in?"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Forgot your Password"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
                  stream: _bloc.getUser(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'your Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _EmailControler,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Pick a question...",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Column(children: <Widget>[
                  DropdownButton<String>(
                    value: selectQA,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String data) {
                      setState(() {
                        selectQA = data;
                      });
                    },
                    items: _item.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ])),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Answer",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
                  stream: _bloc.getAnswer(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'Your answer here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: answerControler,
                  )),
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
                  onPressed: gotoContinute,
                  child: Text(
                    "CONTINUE",
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

  void gotoContinute() {

    print('$hodelr');
    getDropDownItem();
    if (_bloc.isValidateAnswerfogot(_EmailControler.text,answerControler.text)) {
      LoadingDialog.showLoadingDialog(context, "Loading....");
     _bloc.Forgot(_EmailControler.text, '$hodelr', answerControler.text, (){
       LoadingDialog.hideLoadingDialog(context);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassWord(
         key: _refreshKey,
         email: _EmailControler.text,
       )));
     }, (msg){
       LoadingDialog.hideLoadingDialog(context);
       MsgDialog.showMsgDialog(context, "Error", msg);
     });
    }
  }
}
