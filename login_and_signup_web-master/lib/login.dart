import 'package:flutter/material.dart';
import 'package:login_and_signup_web/constants.dart';
import 'Model/UserDetails.dart';
import 'homescreen.dart';

// ignore: must_be_immutable
class LogIn extends StatefulWidget {
  final Function onSignUpSelected;
  UserDetails userDetails = UserDetails(
    userID: 1,
    fullName: 'Aboli Shete',
    userShortName: 'Aboli',
    logonName: 'aboli',
    password: 'aboli',
    mobileNumber: '+919763911480',
    // imeino: '67891',
    //deviceID: '20',
    isActive: true,
  );

  // UserDetails userDetails = UserDetails(
  //   userID: 1,
  //   fullName: 'Aarya Mulaokar',
  //   userShortName: 'Aarya',
  //   logonName: 'aarya',
  //   password: 'aarya',
  //   mobileNumber: '9834431271',
  //   // imeino: '67891',
  //   //deviceID: '20',
  //   isActive: true,
  // );

  LogIn({@required this.onSignUpSelected});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left:150,right:150, top:100,bottom:40),
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
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: Icon(
                            Icons.lock_outline,
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
                                    HomeScreen(widget.userDetails)),
                          )
                          //do something
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
