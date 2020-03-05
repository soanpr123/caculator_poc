
import 'package:flutter/material.dart';

import 'package:caculatorpoc/src/Screens/Login.dart';
import 'package:caculatorpoc/src/bloc/login_bloc.dart';
import 'package:caculatorpoc/src/dialog/Loading.dart';
import 'package:caculatorpoc/src/dialog/msg_dialog.dart';


class ForgotPassWord extends StatefulWidget {
  ForgotPassWord({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _FogotState createState() =>_FogotState();
}
class _FogotState extends State<ForgotPassWord>{
  LoginBloc bloc=new LoginBloc();


  TextEditingController _PassControler=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot PassWord"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
                stream: bloc.getPassword(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'Enter new password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _PassControler,
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
    print(widget.email);
    if(bloc.isValidaPass(_PassControler.text)){
      LoadingDialog.showLoadingDialog(context, "Loading,,,,,");
      bloc.FogotPass(widget.email, _PassControler.text, ()async{
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }, (msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Error", msg);
      });
    }
  }
}
