import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_and_signup_web/Model/CustPerson.dart';
import 'package:intl/intl.dart';
import 'Model/ListVoyFiles.dart';

// ignore: must_be_immutable
class ShipDetails extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;
  ShipDetails(CustPerson custPerson, int custQuoteMasterID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = custQuoteMasterID;
  }

  @override
  _ShipDetailsState createState() => _ShipDetailsState();
}

class _ShipDetailsState extends State<ShipDetails> {
  bool _isEnabled = false;

  final custShipNameController = TextEditingController();
  final customerNameController = TextEditingController();
  final purposeCallController = TextEditingController();
  final callLocController = TextEditingController();
  final agencyTypeDescController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String urlIP = "https://192.168.1.19:45455";
  final dateTimeFormat = new DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  final dateFormat = new DateFormat('dd-MM-yyyy');
  final timeFormat = new DateFormat('HH:mm');
  final etaDateController = TextEditingController();
  final etaTimeController = TextEditingController();
  final etdDateController = TextEditingController();
  final etdTimeController = TextEditingController();
  DateTime now;
  DateTime date;
  DateTime time;
  Map callLocationToID = {
    'Eastern Petroleum Anchorage Alpha': 2,
    'Eastern Special Purposes Anchorage': 3,
    'Eastern Bunkering Anchorage Alpha': 6,
    'Eastern Bunkering Anchorage Bravo': 7,
    'Eastern Bunkering Anchorage Charlie': 8,
    'Changi General Purposes Anchoarge': 9,
    'Changi Holding Anchorage': 10,
    'Algas Anchorage': 11,
    'VLCC Anchorage': 12
  };

  Map idToCallLocation = {
    2: 'Eastern Petroleum Anchorage Alpha',
    3: 'Eastern Special Purposes Anchorage',
    6: 'Eastern Bunkering Anchorage Alpha',
    7: 'Eastern Bunkering Anchorage Bravo',
    8: 'Eastern Bunkering Anchorage Charlie',
    9: 'Changi General Purposes Anchoarge',
    10: 'Changi Holding Anchorage',
    11: 'Algas Anchorage',
    12: 'VLCC Anchorage'
  };
  void initState() {
    super.initState();
    setState(() {
      now = new DateTime.now();
      date = new DateTime(now.year, now.month, now.day);
      time = new DateTime(now.hour, now.minute);
      if (widget.custQuoteMasterID != null)
        getShipDetails(widget.custQuoteMasterID);
    });
  }

  void getShipDetails(int custQuoteMasterID) async {
    try {
      var result = await http
          .get(Uri.parse(urlIP + '/api/ListVoyFile/$custQuoteMasterID'));
      print(custQuoteMasterID);
      if (result.statusCode == 200) {
        ListVoyFiles shipDetails =
            ListVoyFiles.fromJson(jsonDecode(result.body));
        setState(() {
          custShipNameController.text = shipDetails.custShipName;
          customerNameController.text = shipDetails.customerName;
          purposeCallController.text = shipDetails.purposeCall;
          callLocController.text = idToCallLocation[shipDetails.callLocID];
          agencyTypeDescController.text = shipDetails.agencyTypeDesc;
          if (shipDetails.vslETA != null) {
            DateTime eta = dateTimeFormat.parse(shipDetails.vslETA);
            etaDateController.text = dateFormat.format(eta);
            etaTimeController.text = timeFormat.format(eta);
          } else {
            etaDateController.text = '';
            etaTimeController.text = '';
          }
          if (shipDetails.vslETD != null) {
            DateTime etd = dateTimeFormat.parse(shipDetails.vslETD);
            etdDateController.text = dateFormat.format(etd);
            etdTimeController.text = timeFormat.format(etd);
          } else {
            etdDateController.text = '';
            etdTimeController.text = '';
          }
        });
      } else {
        throw Exception('Failed to fetch Ship Details!');
      }
    } catch (Exception) {
      print(Exception.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            // child: Flexible(
            color: Colors.grey[200],
            child: Column(children: [
              (widget.custQuoteMasterID == null)
                  ? Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                          "NO VOYAGE FILE SELECTED. PLEASE SELECT A FILE TO VIEW DETAILS.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center))
                  : Container(),
              Container(
                child: Row(
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
                              padding: EdgeInsets.only(top: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'SHIP NAME',
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: TextField(
                                controller: custShipNameController,
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
                                    decoration: TextDecoration.none,
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'CUSTOMER NAME',
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: TextField(
                                controller: customerNameController,
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
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
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
                              padding: EdgeInsets.only(top: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'PURPOSE OF CALL',
                                // overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: TextField(
                                controller: purposeCallController,
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'AGENCY TYPE',
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: TextField(
                                controller: agencyTypeDescController,
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
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'E.T.A',
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 30,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: TextField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none),
                                controller: etaDateController,
                                enabled: _isEnabled,
                                style: TextStyle(
                                    // overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: TextField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none),
                                controller: etaTimeController,
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
                              //color: kPrimaryColor5,
                              padding: EdgeInsets.only(top: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'E.T.D',
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 30,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: TextField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none),
                                controller: etdDateController,
                                enabled: _isEnabled,
                                style: TextStyle(
                                    // overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: TextField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none),
                                controller: etdTimeController,
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
                  ],
                ),
              ),
              // Flexible(
              //   child:
              Card(
                  margin: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  color: Colors.white,
                  child: Row(children: [
                    Flexible(
                      flex: 8,
                      child: Column(
                        children: [
                          Container(
                            //color: kPrimaryColor5,
                            height: 50,
                            padding: EdgeInsets.only(top: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'VESSEL LOCATION',
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            child: TextField(
                              controller: callLocController,
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
                  ]))
            ])));
  }
}
