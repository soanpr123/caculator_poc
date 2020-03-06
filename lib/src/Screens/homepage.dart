import 'package:caculatorpoc/src/Screens/Caculator.dart';
import 'package:caculatorpoc/src/dialog/chartsBar.dart';
import 'package:caculatorpoc/src/dialog/msg_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class ClicksPerYear {
  final String year;
  final double clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class Caculators {
  final String year;
  final double willhave;
  final charts.Color color;

  Caculators(this.year, this.willhave, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class HomeState extends State<Home> {
  int _counter = 500;
  int _counter2 = 2550;
  int _counter3 = 0;
  int _counter4 = 67;
  int _counter5 = 95;
  double _counter6 = 6;

  List<charts.Series> seriesList;
  TextEditingController _oldControler = new TextEditingController();
  TextEditingController _PreincomeControler = new TextEditingController();
  TextEditingController _curentControler = new TextEditingController();
  TextEditingController _spellingControler = new TextEditingController();
  TextEditingController _otherIncomeControler = new TextEditingController();
  TextEditingController _retireAgeControler = new TextEditingController();
  TextEditingController _lifeExpControler = new TextEditingController();
  TextEditingController _investRateControler = new TextEditingController();
  double _monlthlyControler = 10;
  TextEditingController _monlthlySaveControler = new TextEditingController();
  double willneel = 0;
  double savePerYear = 0;
  double willhave = 0;
  double preofmonth = 0;
  final oCcy = new NumberFormat("0.##", "en_US");
  final oCcy2 = new NumberFormat("0.##", "en_US");
  String formatted;
  bool _isButtonDisabled;
  bool isExpand = false;
  innitText() {
    _oldControler.text = "35";
    _PreincomeControler.text = "60000";
    _curentControler.text = "30000";
    _monlthlySaveControler.text = '$_counter';
    _spellingControler.text = '$_counter2';
    _otherIncomeControler.text = '$_counter3';
    _retireAgeControler.text = '$_counter4';
    _lifeExpControler.text = '$_counter5';
    _investRateControler.text = '$_counter6';
  }

  @override
  void initState() {
    super.initState();
    isExpand = false;
    innitText();
    caculator();
    bool _isButtonDisabled = true;
    onChanedText();
  }

  //nhận sự kiện khi textfield thay đổi fias trị
  void onChanedText() {
    _monlthlySaveControler.addListener(listener);
    _otherIncomeControler.addListener(listener);
    _oldControler.addListener(listener);
    _investRateControler.addListener(listener);
    _spellingControler.addListener(listener);
    _PreincomeControler.addListener(listener);
    _lifeExpControler.addListener(listener);
    _retireAgeControler.addListener(listener);
    _curentControler.addListener(listener);
  }

  listener() {
    caculator();
  }

  void caculator() {
    willNeed(
        double.parse(_lifeExpControler.text),
        double.parse(_retireAgeControler.text),
        double.parse(_spellingControler.text));
    SaveperYear(double.parse(_monlthlySaveControler.text),
        double.parse(_investRateControler.text));
    WillHave(
        int.parse(_retireAgeControler.text),
        int.parse(_oldControler.text),
        int.parse(_curentControler.text),
        int.parse(_otherIncomeControler.text));
    print((willneel + willhave) / 100);
    Monpreincome(int.parse(_monlthlySaveControler.text),
        int.parse(_PreincomeControler.text));
  }

  void Monpreincome(int saveMonth, int PreIncome) {
    _monlthlyControler = (saveMonth / (PreIncome / 12) * 100);
  }

  void willNeed(double lifeExpectancy, double ageRetire, double maintainMonth) {
    willneel = ((lifeExpectancy - ageRetire) * (maintainMonth * 12)) / 1000000;
  }

  void SaveperYear(double savePerMonth, double investRate) {
    savePerYear = (savePerMonth * 12) * (1 + (investRate / 100));
  }

  void WillHave(int ageRetire, int age, int save, int otherIncome) {
    willhave = ((ageRetire - age) * savePerYear + save + otherIncome) / 1000000;
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('You will need about', willneel, Colors.green),
    ];
    var data2 = [
      Caculators('You will have about', willhave, Colors.red),
    ];
    var series = [
      charts.Series(
          domainFn: (ClicksPerYear clickData, _) => clickData.year,
          measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
          colorFn: (ClicksPerYear clickData, _) => clickData.color,
          id: 'Clicks',
          data: data,
          labelAccessorFn: (ClicksPerYear clickData, _) =>
              '${double.parse(oCcy2.format(willneel))} M\$'),
    ];
    var series2 = [
      charts.Series(
          domainFn: (Caculators clickData, _) => clickData.year,
          measureFn: (Caculators clickData, _) => clickData.willhave,
          colorFn: (Caculators clickData, _) => clickData.color,
          id: 'Clicks',
          data: data2,
          labelAccessorFn: (Caculators clickData, _) =>
              '${double.parse(oCcy2.format(willhave))} M\$'),
    ];
    var chart = charts.BarChart(
      series,
      animate: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
    var chart2 = charts.BarChart(
      series2,
      animate: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(0.0),
      child: SizedBox(
        height: 200.0,
        width: 150.0,
        child: chart,
      ),
    );
    var chartWidget2 = Padding(
      padding: EdgeInsets.all(0.0),
      child: SizedBox(
        height: 200.0,
        width: 150.0,
        child: chart2,
      ),
    );
    // TODO: implement build
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: new Container(
          margin:
              EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Retirement caculator",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text(
                      "Tell us a few things abuot yourself, and this caculator will show whether you're on track for the retirement you want",
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "I am ",
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.normal),
                        ),
                        SizedBox(
                            width: 60,
                            child: new TextField(
                                style: TextStyle(fontSize: 20, height: 2.0),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter'),
                                controller: _oldControler)),
                        Container(
                          child: Text(
                            " years old,",
                            style: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "My pre-tax income is (\$) ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                            width: 100,
                            child: new TextField(
                              style: TextStyle(fontSize: 20, height: 2.0),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter '),
                              controller: _PreincomeControler,
                            )),
                        Container(
                          child: Text(
                            " and I have current ",
                            style: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Saving of  ",
                            style: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.normal),
                          ),
                        ),
                        SizedBox(
                            width: 100,
                            child: new TextField(
                              style: TextStyle(fontSize: 20, height: 2.0),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                border: OutlineInputBorder(),
                              ),
                              controller: _curentControler,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Every month I save (\$)",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      if (_counter == 0) {
                                        _isButtonDisabled = false;
                                      } else {
                                        _isButtonDisabled = true;
                                        _counter = _counter - 50;
                                        _monlthlySaveControler.text =
                                            '$_counter';
                                        caculator();
                                      }
                                    });
                                  },
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                  width: 150,
                                  child: new TextField(
                                    style: TextStyle(fontSize: 20, height: 2.0),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter'),
                                    controller: _monlthlySaveControler,
                                  )),
                              SizedBox(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _counter = _counter + 50;
                                      _monlthlySaveControler.text = '$_counter';
                                      caculator();
                                    });
                                  },
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          formatted = oCcy.format(_monlthlyControler),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 15.0),
                        child: Text(
                          "% of my monthly income",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: (isExpand == true)
                        ? const EdgeInsets.all(8.0)
                        : const EdgeInsets.all(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: (isExpand != true)
                              ? BorderRadius.all(Radius.circular(8))
                              : BorderRadius.all(Radius.circular(22)),
                        ),
                        child: ExpansionTile(
                          title: Container(
                              width: double.infinity,
                              child: Text(
                                "Optional",
                                style: TextStyle(
                                    fontSize: (isExpand != true) ? 18 : 22),
                              )),
                          trailing: (isExpand == true)
                              ? Icon(
                                  Icons.arrow_drop_down,
                                  size: 32,
                                  color: Colors.pink,
                                )
                              : Icon(Icons.arrow_drop_up,
                                  size: 32, color: Colors.pink),
                          onExpansionChanged: (value) {
                            setState(() {
                              isExpand = value;
                            });
                          },
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "Monthly retirement spending (\$)",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          MsgDialog.showMsgDialog(
                                              context,
                                              "note",
                                              "A common rule of thumb is living 70% of current income "
                                                  "(using savings, investments, Social"
                                                  " Security and other sources, such as a pension).");
                                        },
                                        child: Container(
                                          child: Text(
                                            "?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          height: 30,
                                          alignment: Alignment.center,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: Colors.black),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                if (_counter2 == 0) {
                                                  _isButtonDisabled = false;
                                                } else {
                                                  _counter2 = _counter2 - 100;
                                                  _spellingControler.text =
                                                      '$_counter2';
                                                  caculator();
                                                }
                                              });
                                            },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: new TextField(
                                              style: TextStyle(
                                                  fontSize: 20, height: 2.0),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter'),
                                              controller: _spellingControler,
                                            )),
                                        SizedBox(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                _counter2 = _counter2 + 100;
                                                _spellingControler.text =
                                                    '$_counter2';
                                                caculator();
                                              });
                                            },
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "Other expected income(\$)",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          MsgDialog.showMsgDialog(
                                              context,
                                              "note",
                                              "Add any other expected retirement income (Social Security, pension, etc.)."
                                                  " Need to estimate your Social "
                                                  "Security benefits? See the link under \"How we got here.\"");
                                        },
                                        child: Container(
                                          child: Text(
                                            "?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          height: 30,
                                          alignment: Alignment.center,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: Colors.black),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                if (_counter3 == 0) {
                                                  _isButtonDisabled = false;
                                                } else {
                                                  _counter3 = _counter3 - 100;
                                                  _otherIncomeControler.text =
                                                      '$_counter3';

                                                  caculator();
                                                }
                                              });
                                            },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: new TextField(
                                              style: TextStyle(
                                                  fontSize: 20, height: 2.0),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter'),
                                              controller: _otherIncomeControler,
                                            )),
                                        SizedBox(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                _counter3 = _counter3 + 100;
                                                _otherIncomeControler.text =
                                                    '$_counter3';
                                                caculator();
                                              });
                                            },
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "I want to retire at age",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        MsgDialog.showMsgDialog(
                                            context,
                                            "note",
                                            "Most people go with 67. Cf course, "
                                                "the longer you work, the more you can save.");
                                      },
                                      child: Container(
                                        child: Text(
                                          "?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        height: 30,
                                        alignment: Alignment.center,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2.0,
                                                color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              if (_counter4 == 0) {
                                                _isButtonDisabled = false;
                                              } else {
                                                _counter4 = _counter4 - 1;
                                                _retireAgeControler.text =
                                                    '$_counter4';
                                                caculator();
                                              }
                                            });
                                          },
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: new TextField(
                                            style: TextStyle(
                                                fontSize: 20, height: 2.0),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                border: OutlineInputBorder(),
                                                hintText: 'Enter'),
                                            controller: _retireAgeControler,
                                          )),
                                      SizedBox(
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              _counter4 = _counter4 + 1;
                                              _retireAgeControler.text =
                                                  '$_counter4';
                                              caculator();
                                            });
                                          },
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Life expectancy",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        MsgDialog.showMsgDialog(
                                            context,
                                            "note",
                                            "People are living longer and healthier lives,"
                                                " so it's wise to plan for a long retirement.");
                                      },
                                      child: Container(
                                        child: Text(
                                          "?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        height: 30,
                                        alignment: Alignment.center,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2.0,
                                                color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          color: Colors.white,
                                          onPressed: () {
                                            if (_counter5 == 0) {
                                              _isButtonDisabled = false;
                                            } else {
                                              _counter5 = _counter5 - 1;
                                              _lifeExpControler.text =
                                                  '$_counter5';
                                              caculator();
                                            }
                                          },
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: new TextField(
                                            style: TextStyle(
                                                fontSize: 20, height: 2.0),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                border: OutlineInputBorder(),
                                                hintText: 'Enter'),
                                            controller: _lifeExpControler,
                                          )),
                                      SizedBox(
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              _counter5 = _counter5 + 1;
                                              _lifeExpControler.text =
                                                  '$_counter5';
                                              caculator();
                                            });
                                          },
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Investment rate of return(%)",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        MsgDialog.showMsgDialog(
                                            context,
                                            "note",
                                            "What do you expect your investments to earn between now and retirement?"
                                                " Our default of a 6% average annual return is a"
                                                " conservative estimate based on historic returns.");
                                      },
                                      child: Container(
                                        child: Text(
                                          "?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        height: 30,
                                        alignment: Alignment.center,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2.0,
                                                color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                if (_counter6 == 0) {
                                                  _isButtonDisabled = false;
                                                } else {
                                                  _counter6 = _counter6 - 0.5;
                                                  _investRateControler.text =
                                                      '$_counter6';
                                                  caculator();
                                                }
                                              });
                                            },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: new TextField(
                                              style: TextStyle(
                                                  fontSize: 20, height: 2.0),
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter'),
                                              controller: _investRateControler,
                                            )),
                                        SizedBox(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                _counter6 = _counter6 + 0.5;
                                                _investRateControler.text =
                                                    '$_counter6';
                                                caculator();
                                              });
                                            },
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "How much will you need to retire at 67?(\$)",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          chartWidget2,
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          chartWidget,
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Retirement savings score",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ////Thanh score đây :
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:10.0,
                            right: MediaQuery.of(context).size.width /100),
                        child: Text("You are 51% \nto goal",
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width - 400),
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,

                    child: Stack(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    color: Colors.red),
                                height: 50,
                                width: 100,
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    color: Colors.yellow),
                                height: 50,
                                width: 120,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      color: Colors.blue),
                                  height: 50,
                                  width: 60),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    color: Colors.lightGreen),
                                height: 50,
                                width: 40,
                              ),
                            ],
                          ),
                        ],
                      ),

                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Let's get Future You",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      "Out the red.",
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
