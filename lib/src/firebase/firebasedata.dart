import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirAuth {
  final databaseReference = Firestore.instance;

  static final FirAuth _intanse = new FirAuth.internal();
  FirAuth.internal();
  factory FirAuth() {
    return _intanse;
  }

//  void Sign() {
//
//      databaseReference.collection("users").document(Email).get().then((DocumentSnapshot){
//        String password=DocumentSnapshot.data["password"];
//        print(password);
//
//        if(PassWord==password){
//          print("thành công");
//          onSucces();
//        }else{
//          onRegisterErr("SignUp fail, please try again");
//        }
//      });

//   if(PassWord){
//
//   }
//  }

  void createUser(
      String email,
      String answer,
      String first_name,
      String last_name,
      String password,
      String question,
      Function onSucces,
      Function(String) onRegisterErr) async {
    var user = {
      "answer": answer,
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "password": password,
      "question": question,
    };
    await databaseReference.collection("users").document(email).setData(user);
    onSucces();
  }

  void updatePasss(String Email, String password, Function onSucces,
      Function(String) onRegisterErr) async {
    databaseReference
        .collection("users")
        .document(Email)
        .updateData({'password': password});
    onSucces();
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }
}
