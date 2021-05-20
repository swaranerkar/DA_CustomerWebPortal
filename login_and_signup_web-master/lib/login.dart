import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_and_signup_web/OtpPage.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:login_and_signup_web/homescreen.dart';
import 'Model/CustPerson.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:requests/requests.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

// ignore: must_be_immutable
class LogIn extends StatefulWidget {
  final Function onSignUpSelected;
  LogIn({@required this.onSignUpSelected});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // ignore: non_constant_identifier_names
  final UserNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final PasswordController = TextEditingController();
  bool _isHidden = true;

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToastLogin() {
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
            "Failed to login, please check username and password!",
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

  _showToastAuth() {
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
            "Please enter all required fields!",
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

  void authUser(String uname, String pswd) async {
    String url = 'https://192.168.1.5:45455/api/CustPerson/login/$uname/$pswd';

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      CustPerson custPerson = CustPerson.fromJson(jsonDecode(res.body));

      String url1 =
          'http://192.168.1.5:45455/api/OTPController/GetOTP/${custPerson.cPerUName}/${custPerson.custPersonEmail}';
      http.Response res1 = await http.get(Uri.parse(url1));

      print("OTP sent response code:");
      print(res1.statusCode);
      print(res1.headers);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtpPage(custPerson.cPerUName, custPerson.custPersonEmail)));
    } else {
      print('Invalid Credentials');
      _showToastLogin();
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
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
                        "LOG IN",
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
                        controller: UserNameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          labelText: 'Username',
                          suffixIcon: Icon(
                            Icons.mail_outline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextField(
                        controller: PasswordController,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: Icon(
                            Icons.lock,
                          ),
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                          if (UserNameController.text != "" &&
                              PasswordController.text != "")
                            {
                              authUser(UserNameController.text,
                                  PasswordController.text)
                            }
                          else
                            {
                              print('Invalid'),
                              _showToastAuth(),
                            }
                        },
                        child: new Text("LOGIN"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
