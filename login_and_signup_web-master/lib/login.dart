import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_and_signup_web/OtpPage.dart';
import 'package:login_and_signup_web/constants.dart';
import 'Model/CustPerson.dart';
import 'homescreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class LogIn extends StatefulWidget {
  final Function onSignUpSelected;

  // Customer customer = Customer(
  //   customerID: 1,
  //   customerName: "shruti",
  //   customerRef: "shruti",
  //   isActive: true,
  // );
  /* CustPerson custPerson = CustPerson(
      customerID: 1,
      custPersonID: 300000,
      custPersonFullName: "aarya",
      custPersonDesignation: "employee",
      custPersonTelMob: "9834431271",
      custPersonEmail: "aaryamulaokar24@gmail.com",
      cPerUName: "aarya",
      cPerPwd: "aarya",
      isActive: true);*/

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

  void authUser(String uname, String pswd) async {
    String url = 'https://192.168.1.9:45455/api/CustPerson/login/$uname/$pswd';
    var res = await http.get(Uri.parse(url));
    // print("OTP sent response code:");
    //  print(res.statusCode);
    //  print(res.headers);
    // setState(() {
    //   this.rawCookie = res.headers['set-cookie'];
    //  });

    String result = "Success";
    if (res.statusCode == 200) {
      CustPerson custPerson = CustPerson.fromJson(jsonDecode(res.body));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(custPerson))); //userID)))

    } else {
      print('Invalid Credentials');
      Fluttertoast.showToast(
          msg: "Failed to login, please check username and password!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xffD09FA6),
          textColor: Colors.white,
          fontSize: 15.0);
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
                              Fluttertoast.showToast(
                                  msg: "Please enter all required fields!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: const Color(0xffD09FA6),
                                  textColor: Colors.white,
                                  fontSize: 15.0)
                            }
                        },
                        child: new Text("LOGIN"),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Forgot Password?",
                            style: TextStyle(
                              color: kPrimaryColor2,
                              fontSize: 14,
                            ),
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
    );
  }
}
