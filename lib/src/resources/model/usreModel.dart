
class User {
  String _id;
  String _email;
  String _first_name;
  String _last_name;
  String _password;
  String _question;
  String _anser;


  User(this._email, this._first_name, this._last_name, this._password,
      this._question, this._anser);

  String get anser => _anser;

  set anser(String value) {
    _anser = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get last_name => _last_name;

  set last_name(String value) {
    _last_name = value;
  }

  String get first_name => _first_name;

  set first_name(String value) {
    _first_name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}