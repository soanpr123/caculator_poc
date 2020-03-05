import 'package:caculatorpoc/src/Screens/Login.dart';
import 'package:caculatorpoc/src/bloc/login_bloc.dart';
import 'package:caculatorpoc/src/dialog/Loading.dart';
import 'package:caculatorpoc/src/dialog/msg_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoUser extends StatefulWidget {
  InfoUser({Key key, this.email, this.password,this.answer,this.question}) : super(key: key);
  final String email;
  final String password;
  final String question;
  final String answer;
  @override
  _InfoUserState createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
LoginBloc _bloc=new  LoginBloc();
  TextEditingController _first_nameControler = new TextEditingController();
  TextEditingController _last_nameControler = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text("What your name ?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
//                  stream: bloc.getUser(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'Legal first name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _first_nameControler,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: StreamBuilder(
//                  stream: bloc.getPassword(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'Legal last name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,

                    ),
                    controller: _last_nameControler,
                  )),
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
                  onPressed: Onsignclick,
                  child: Text("SIGN UP"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Onsignclick() {
print(widget.email);
print(widget.password);
print(widget.question);
print(widget.answer);
LoadingDialog.showLoadingDialog(context, "Loading.......");
_bloc.SignUp(widget.email, widget.answer, _first_nameControler.text, _last_nameControler.text, widget.password, widget.question, (){
  LoadingDialog.hideLoadingDialog(context);
  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));

},(msg) {
LoadingDialog.hideLoadingDialog(context);
MsgDialog.showMsgDialog(context, "Error", msg);
});

  }
}
