import 'dart:async';

import 'package:caculatorpoc/src/firebase/firebasedata.dart';
import 'package:caculatorpoc/src/validators/validater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginBloc {
  var _auTh = FirAuth();
  StreamController _Usercontroller = new StreamController();
  StreamController _Passcontroller = new StreamController();
  StreamController _AnswerControler = new StreamController();
  StreamController Checkmail = new StreamController();
  final databaseReference = Firestore.instance;

  Stream getUser() {
    return _Usercontroller.stream;
  }

  Stream getPassword() {
    return _Passcontroller.stream;
  }

  Stream getAnswer() {
    return _AnswerControler.stream;
  }

  Stream CheckMail() {
    return Checkmail.stream;
  }

  bool isValidaInfo(String username, String Password) {
    if (!Validation.isvaliUser(username)) {
      _Usercontroller.sink.addError("Invalid email");
      return false;
    }
    _Usercontroller.sink.add("ok");
    if (!Validation.isvaliPass(Password)) {
      _Passcontroller.sink.addError("Password must be over 8 characters");
      return false;
    }

    _Passcontroller.sink.add("ok");
    return true;
  }
  bool isValidaPass(String Password) {
    if (!Validation.isvaliPass(Password)) {
      _Passcontroller.sink.addError("Password must be over 8 characters");
      return false;
    }
    _Passcontroller.sink.add("ok");
    return true;
  }
  bool check(String Email, String PassWord, Function onSucces,
      Function(String) onRegisterErr) {
    databaseReference
        .collection("users")
        .document(Email)
        .get()
        .then((DocumentSnapshot) {
      final reroust = DocumentSnapshot.data;
      print(reroust);
      if (reroust == null) {
        print("sai ");
        onRegisterErr("Sign In fail, Email is incorrect please enter again.");
        return false;
      } else {
        String password = DocumentSnapshot.data["password"];
        print(password);
        if (PassWord == password) {
          print("thành công");
          onSucces();
        } else {
          onRegisterErr("Sign In fail, please check Email and PassWord and try again");
        }
        return true;
      }
    });
  }

  bool checkFogot(String Email, String Question, String Answers,
      Function onSucces, Function(String) onRegisterErr) {
    databaseReference
        .collection("users")
        .document(Email)
        .get()
        .then((DocumentSnapshot) {
      final reroust = DocumentSnapshot.data;
      print(reroust);
      if (reroust == null) {
        print("sai ");
        onRegisterErr("Sign In fail, Email is incorrect please enter again.");
        return false;
      } else {
        String question = DocumentSnapshot.data["question"];
        String answer = DocumentSnapshot.data["answer"];
        print(question);
        print(answer);
        if (Question == question && Answers == answer) {
          print("thành công");
          onSucces();
        } else {
          onRegisterErr("Check the selected fields again");
        }
        return true;
      }
    });
  }

  void SignUp(
      String email,
      String answer,
      String first_name,
      String last_name,
      String password,
      String question,
      Function onSucces,
      Function(String) onRegisterErr) {
    _auTh.createUser(email, answer, first_name, last_name, password, question,
        onSucces, onRegisterErr);
  }

  void Sign(String Email, String PssWord, Function onSucces,
      Function(String) onRegisterErr) {
    check(Email, PssWord, onSucces, onRegisterErr);
  }
  void Forgot(String Email, String Question, String Answers,
      Function onSucces, Function(String) onRegisterErr) {
    checkFogot(Email, Question, Answers, onSucces, onRegisterErr);
  }
void FogotPass(String Email, String PssWord, Function onSucces,
    Function(String) onRegisterErr){
_auTh.updatePasss(Email, PssWord, onSucces, onRegisterErr);
}
  bool isValidateAnswer(String answer) {
    if (!Validation.isvaliAnswer(answer)) {
      _AnswerControler.sink.addError("Do not leave this field blank!");
      return false;
    }
    _Usercontroller.sink.add("ok");
    return true;
  }

  bool isValidateAnswerfogot(String Email, String answer) {
    if (!Validation.isvaliAnswer(answer)) {
      _AnswerControler.sink.addError("Do not leave this field blank!");
      return false;
    }
    _AnswerControler.sink.add("ok");
    if (!Validation.isvaliUser(Email)) {
      _Usercontroller.sink.addError("Invalid email");
      return false;
    }
    _Usercontroller.sink.add("ok");
    return true;
  }

  void Isclose() {
    _Usercontroller.close();
    _Passcontroller.close();
    _AnswerControler.close();
  }
}
