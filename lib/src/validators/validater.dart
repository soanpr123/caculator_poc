import 'package:email_validator/email_validator.dart';

class Validation{
  static  bool isvaliUser(String user){
//    String pattern ="[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$";
//    RegExp regExp = new RegExp(pattern);
    return user!=null && user.length > 6 && user.contains("@") && EmailValidator.validate(user) ;
  }
  static bool isvaliPass(String pass){
    return pass!=null && pass.length>=8;
  }
  static bool isvaliAnswer(String answer){
    return answer.length>0;
  }
}