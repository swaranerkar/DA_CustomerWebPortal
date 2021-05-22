import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:login_and_signup_web/login.dart';
import 'package:login_and_signup_web/main.dart';
import 'package:timer_button/timer_button.dart';
import 'Model/CustPerson.dart';
import 'homescreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:firebase/firebase.dart' as fb;

// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  String emailID;
  String uName;
  OtpPage(String uName, String emailID) {
    this.uName = uName;
    this.emailID = emailID;
  }

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();

  _OtpPageState() {}

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToastOTP() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kPrimaryColor2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 8.0,
          ),
          Text(
            "OTP verification failed.Try again!",
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }

  _showToastResend() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kPrimaryColor2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 8.0,
          ),
          Text(
            "Please re-enter the following details!",
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }

  Future<CustPerson> validateOTP(int otp) async {
    try {
      var result = await http.get(
        Uri.parse(
            'https://192.168.1.5:45455/api/OTPController/ValidateWebOTP/${widget.uName}/$otp'),
      );
      print("Result");
      print(result.statusCode);
      print(result.headers);
      print(result.body);
      if (result.statusCode == 200) {
        if (result.body.isNotEmpty) {
          CustPerson custPerson = CustPerson.fromJson(jsonDecode(result.body));
          return custPerson;
        }
      } else {
        _showToastOTP();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      }
      // }
      // }
    } catch (Exception) {
      print(Exception.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
                            "OTP will expire in 3 minutes",
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
                            height: 32,
                          ),
                          new RaisedButton(
                            color: Colors.white,
                            textColor: Colors.black,
                            elevation: 5.0,
                            splashColor: kPrimaryColor2,
                            padding: EdgeInsets.fromLTRB(53, 20, 53, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () async {
                              {
                                CustPerson custPerson = await validateOTP(
                                    int.parse(otpController.text));
                                if (custPerson == null) {
                                  print("No user");
                                  _showToastOTP();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                } else {
                                  print('User In');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeScreen(custPerson)));
                                }
                              }
                            },
                            child: new Text("SUBMIT"),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          ArgonTimerButton(
                            initialTimer: 180, // Optional
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.11,
                            minWidth: MediaQuery.of(context).size.width * 0.11,
                            color: Colors.white,
                            borderRadius: 30,
                            child: Text("Resend OTP",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            loader: (timeLeft) {
                              return Text(
                                "Time Left | $timeLeft",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              );
                            },
                            onTap: (startTimer, btnState) {
                              if (btnState == ButtonState.Idle) {
                                //startTimer(5);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
