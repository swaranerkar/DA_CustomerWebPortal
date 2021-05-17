import 'dart:html';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/Model/CustPerson.dart';
import 'VoyageFilesScreen.dart';
import 'constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  //UserDetails userDetails;
  CustPerson custPerson;
  HomeScreen(CustPerson custPerson) {
    //this.userDetails = userDetails;
    this.custPerson = custPerson;
  }

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
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
                            builder: (context) =>
                                HomeScreen(widget.custPerson)),
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
                              builder: (context) =>
                                  VoyageFilesScreen(widget.custPerson, null))),

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
    );
  }
}
