import 'dart:async';

class Caculate_Bloc{
  StreamController ageController=new StreamController();
  StreamController incomeControler=new StreamController();
  StreamController CurentControler=new StreamController();
  StreamController saveMonthControler=new StreamController();
  StreamController _spellingControler = new StreamController();
  StreamController _otherIncomeControler = new StreamController();
  StreamController _retireAgeControler = new StreamController();
  StreamController _lifeExpControler = new StreamController();
  StreamController _investRateControler = new StreamController();
  Stream getAge(){
    return ageController.stream;
  }
  Stream getIncome(){
    return incomeControler.stream;
  }
  Stream getCurrent(){
    return CurentControler.stream;
  }
  Stream getSavemont(){
    return saveMonthControler.stream;
  }
  Stream getSpell(){
    return _spellingControler.stream;
  }
  Stream getOther(){
    return _otherIncomeControler.stream;
  }
  Stream getRetire(){
    return _retireAgeControler.stream;
  }
  Stream getLifeExp(){
    return _lifeExpControler.stream;
  }
  Stream getInvess(){
    return _investRateControler.stream;
  }
  void willNeed (String lifeExpectancy,String ageRetire,String maintainMonth , Function onSucces){

  }
  void Isclose() {
    ageController.close();
    incomeControler.close();
    CurentControler.close();
    saveMonthControler.close();
    _spellingControler.close();
    _otherIncomeControler.close();
    _retireAgeControler.close();
    _lifeExpControler.close();
    _investRateControler.close();

  }
}