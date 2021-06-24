import 'dart:html';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_and_signup_web/Model/CustPerson.dart';
import 'package:login_and_signup_web/login.dart';
import 'ClosedVoyageFilesScreen.dart';
import 'OpenVoyageFilesScreen.dart';
import 'constants.dart';
import 'main.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  CustPerson custPerson;
  HomeScreen(CustPerson custPerson) {
    this.custPerson = custPerson;
  }

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class Constants {
  static const String SignOut = 'SIGN OUT';
  static const List<String> choices = [SignOut];
}

class _HomeScreenState extends State<HomeScreen> {
  void choiceAction(String choice) {
    if (choice == Constants.SignOut) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(widget.custPerson)));
      },
    );
    Widget logoutButton = FlatButton(
      child: Text("Logout"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Kindly logout before you exit !"),
      actions: [
        cancelButton,
        logoutButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => showAlertDialog(context),
      // Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => MyApp())),
      child: Scaffold(
        backgroundColor: kPrimaryColor3,
        body: new Column(children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
                child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Ship.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                    // The Positioned widget is used to position the text inside the Stack widget
                    right: 40,
                    top: 30,
                    child: Text(
                      "Welcome, " + widget.custPerson.custPersonFullName,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )),
                Positioned(
                    left: 40,
                    top: 30,
                    child: PopupMenuButton<String>(
                      onSelected: choiceAction,
                      icon: Icon(Icons.menu, color: Colors.white),
                      itemBuilder: (BuildContext context) {
                        return Constants.choices.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          );
                        }).toList();
                      },
                    ))
              ],
            )),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor1,
                        onPrimary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClosedVoyageFilesScreen(
                                  widget.custPerson, null)),
                        )
                        //do something
                      },
                      child: new Text("VIEW CLOSED VOYAGE FILES",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 150,
                    height: 100,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor1,
                        onPrimary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenVoyageFilesScreen(
                                    widget.custPerson, null))),

                        //do something
                      },
                      child: new Text("VIEW OPEN VOYAGE FILES",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            )),
          )
        ]),
      ),
    );
  }
}
