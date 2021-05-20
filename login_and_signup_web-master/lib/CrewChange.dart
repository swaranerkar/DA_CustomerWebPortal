import 'package:flutter/material.dart';
import 'package:login_and_signup_web/CTMDeliveryPage.dart';
import 'package:login_and_signup_web/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Model/CrewChange.dart';
import 'Model/CustPerson.dart';

// ignore: must_be_immutable
class CrewChangeWidget extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;
  CrewChangeWidget(CustPerson custPerson, int custQuoteMasterID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  _CrewChangeWidgetState createState() => _CrewChangeWidgetState();
}

class _CrewChangeWidgetState extends State<CrewChangeWidget> {
  bool _isEnabled = false;
  CrewChange crewChange;
  final signOnController = TextEditingController();
  final signOffController = TextEditingController();
  final remarksController = TextEditingController();
  DateTime now;
  DateTime date;
  String urlIP = "https://192.168.1.5:45455";
  void initState() {
    super.initState();

    setState(() {
      now = new DateTime.now();
      date = new DateTime(now.year, now.month, now.day);
      if (widget.custQuoteMasterID != null)
        getCrewChangeInfo(widget.custQuoteMasterID);
    });
  }

  void getCrewChangeInfo(int custQuoteMasterID) async {
    try {
      var result = await http
          .get(Uri.parse(urlIP + '/api/CrewChange/$custQuoteMasterID'));
      if (result.statusCode == 200) {
        setState(() {
          this.crewChange = CrewChange.fromJson(jsonDecode(result.body));
          signOnController.text = crewChange.signOn.toString();
          signOffController.text = crewChange.signOff.toString();
          remarksController.text = crewChange.remarks;
        });
      } else {
        throw Exception('Failed to fetch crew change information!');
      }
    } catch (Exception) {
      print(Exception.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //     child:
        //return SafeArea(
        child: Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          (widget.custQuoteMasterID == null)
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                      "NO VOYAGE FILE SELECTED. PLEASE SELECT A FILE TO VIEW DETAILS.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
              : Container(),
          Card(
            color: kPrimaryColor1,
            margin: EdgeInsets.symmetric(horizontal: 10),
            //margin: EdgeInsets.all(10),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              width: 2000,
              child: Text(
                "CREW CHANGE",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Card(
                  margin: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        //color: kPrimaryColor5,
                        padding: EdgeInsets.only(top: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SIGN ON',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 40,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: TextField(
                          controller: signOnController,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          enabled: _isEnabled,
                          style: TextStyle(
                              // overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Card(
                  margin: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SIGN OFF',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 40,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: TextField(
                          controller: signOffController,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                          enabled: _isEnabled,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Column(
              children: [
                Container(
                  //color: kPrimaryColor5,
                  padding: EdgeInsets.only(top: 10),
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'REMARKS',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: TextField(
                    controller: remarksController,
                    enabled: _isEnabled,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    style: TextStyle(
                        // overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          CTMDeliveryWidget(widget.custPerson, widget.custQuoteMasterID),
        ],
      ),
    ));
  }
}
