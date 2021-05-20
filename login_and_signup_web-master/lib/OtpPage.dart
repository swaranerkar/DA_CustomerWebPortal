import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:login_and_signup_web/login.dart';
import 'package:timer_button/timer_button.dart';
import 'Model/CustPerson.dart';
import 'homescreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:firebase/firebase.dart' as fb;

// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  //final Function onSignUpSelected;
  // CustPerson custPerson;
  String emailID;
  String uName;
  String rawCookie;
  OtpPage(String uName, String emailID, String rawCookie) {
    //this.custPerson = custPerson;
    this.uName = uName;
    this.emailID = emailID;
    this.rawCookie = rawCookie;
  }
  //OtpPage({@required this.onSignUpSelected});

  @override
  _OtpPageState createState() => _OtpPageState(rawCookie);
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();
  String rawCookie;
  Option selectedOption = Option.LogIn;

  _OtpPageState(String rawCookie) {
    this.rawCookie = rawCookie;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<CustPerson> validateOTP(int otp) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      //if (rawCookie != null) {
      //  int index = rawCookie.indexOf(';');
      // headers['cookie'] =
      // (index == -1) ? rawCookie : rawCookie.substring(0, index);
      //  if (rawCookie != null) {
      // int index = rawCookie.indexOf(';');
      var result = await http.get(Uri.parse(
          'https://192.168.1.9:45455/api/OTPController/ValidateWebOTP/${widget.uName}/$otp'));
      print("Result");
      print(result.statusCode);
      print(result.body);
      if (result.statusCode == 204) {
        if (result.body.isNotEmpty) {
          CustPerson custPerson = CustPerson.fromJson(jsonDecode(result.body));
          return custPerson;
        }
      } else {
        Fluttertoast.showToast(
            msg: "OTP verification failed.Try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color(0xffD09FA6),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LogIn(
                      onSignUpSelected: () {
                        setState(() {
                          selectedOption = Option.SignUp;
                        });
                      },
                    )));
      }
      //   }
      // }
    } catch (Exception) {
      print(Exception.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            body: Container(
                color: Colors.white,
                child: ListView(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(8)),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 50),
                          height: 275,
                          child: Card(
                              color: Colors.white,
                              elevation: 50,
                              child: Column(children: <Widget>[
                                Text(
                                  '\nOTP will expire in 3 minutes\n',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: otpController,
                                      decoration: InputDecoration(
                                        hintText: ' Enter OTP',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey[400])),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(top: 20),
                                    height: 65,
                                    width: 180,
                                    child: RaisedButton(
                                        color: const Color(0xffB4656F),
                                        child: Text(
                                          'SUBMIT',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () async {
                                          CustPerson custPerson =
                                              await validateOTP(int.parse(
                                                  otpController.text));
                                          if (custPerson == null) {
                                            print("No user");
                                            Fluttertoast.showToast(
                                                msg:
                                                    "OTP verification failed.Try again!",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    const Color(0xffD09FA6),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => LogIn(
                                                          onSignUpSelected: () {
                                                            setState(() {
                                                              selectedOption =
                                                                  Option.SignUp;
                                                            });
                                                          },
                                                        )));
                                          } else {
                                            print('User In');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(
                                                            custPerson)));
                                          }
                                        }))
                              ]))),
                      Container(
                          width: 210,
                          height: 45,
                          child: new TimerButton(
                            label: "RESEND",
                            timeOutInSeconds: 180,
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "Please re-enter the following details!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color(0xffD09FA6),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn(
                                            onSignUpSelected: () {
                                              setState(() {
                                                selectedOption = Option.SignUp;
                                              });
                                            },
                                          )));
                            },
                            disabledColor: const Color(0xffB4656F),
                            color: Color(0xff98c1d9),
                            disabledTextStyle: new TextStyle(fontSize: 20.0),
                            activeTextStyle: new TextStyle(
                                fontSize: 20.0, color: Colors.black),
                          )) //userID)))
                    ],
                  )
                ]))));
  }
}

/*
Container(
      height: double.infinity,
      color: kPrimaryColor3,
      child: Padding(
        padding: EdgeInsets.only(left: 150, right: 150, top: 100, bottom: 40),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 500,
              width: 400,
              color: kPrimaryColor1,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter OTP",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 30,
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextField(
                          controller: otpController,
                          decoration: InputDecoration(
                            hintText: 'Enter OTP',
                            labelText: 'Enter OTP',
                            suffixIcon: Icon(
                              Icons.mail_outline,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        new RaisedButton(
                          color: Colors.white,
                          textColor: Colors.black,
                          elevation: 5.0,
                          splashColor: kPrimaryColor2,
                          padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(widget.custPerson)))
                          },
                          child: new Text("Submit"),
                        ),
                        
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );*/