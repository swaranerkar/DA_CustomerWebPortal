import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_and_signup_web/Model/UserDetails.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:login_and_signup_web/homescreen.dart';
import 'package:intl/intl.dart';
import 'Model/ListVoyFiles.dart';

// ignore: must_be_immutable
class ShipDetails extends StatefulWidget {
  UserDetails userDetails;
  int custQuoteMasterID;
  ShipDetails(UserDetails userDetails, int custQuoteMasterID) {
    this.userDetails = userDetails;
    this.custQuoteMasterID = custQuoteMasterID;
  }

  @override
  _ShipDetailsState createState() => _ShipDetailsState();
}

class _ShipDetailsState extends State<ShipDetails> {
  bool _isEnabled = false;
  // final daReferenceController = TextEditingController();
  final custShipNameController = TextEditingController();
  final customerNameController = TextEditingController();
  final purposeCallController = TextEditingController();
  final callLocController = TextEditingController();
  final agencyTypeDescController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

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
      var result = await http.get(Uri.parse(
          'https://192.168.1.106:45455/api/ListVoyFile/$custQuoteMasterID'));
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
    /* final shipNameController = TextEditingController();
    final custNameController = TextEditingController();
    final purposeOfCallController = TextEditingController();
    final vesselLocController = TextEditingController();
    final agencyTypeController = TextEditingController();
    final etaController = TextEditingController();
    final etdController = TextEditingController();

    shipNameController.text = 'MT.DS.POWER';
    custNameController.text = 'INTERNANTIONAL TANKER MANAGEMENT(GERMANY)';
    purposeOfCallController.text = 'goods delivery';
    vesselLocController.text = 'Algas Anchorage';
    agencyTypeController.text = 'Agency';
    etaController.text = '10-04-2021   02:00';
    etdController.text = '10-04-2021   19:00';*/

    return SingleChildScrollView(
        child: Container(
            // child: Flexible(
            color: Colors.grey[200],
            child: Column(children: [
              (widget.custQuoteMasterID == null)
                  ? Container(
                    margin: EdgeInsets.all(8),
                      child: Text(
                          "NO VOYAGE FILE SELECTED. PLEASE SELECT A FILE TO VIEW DETAILS.",
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                         )
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
                        //shadowColor: Colors.grey[200],
                        //shape: ,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              //color: kPrimaryColor5,
                              // padding: EdgeInsets.only(
                              //   top: 10,
                              // ),
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
                              //height: 50,
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
                              //color: kPrimaryColor5,
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
                              //color: kPrimaryColor5,
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
                              //color: kPrimaryColor5,
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
                    // Flexible(
                    //   flex: 2,
                    //   child: Container(
                    //       height: 50,
                    //       width: 150,
                    //       color: kPrimaryColor1,
                    //       margin: EdgeInsets.symmetric(horizontal: 4),
                    //       child: GestureDetector(
                    //         onTap: () => {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     HomeScreen(widget.userDetails)),
                    //           )
                    //         },
                    //         child: Row(
                    //           children: [
                    //             // Padding(
                    //             //     padding: EdgeInsets.only(left: 20),
                    //             //     child: Text("VIEW ON MAP")),
                    //             // Icon(
                    //             //   Icons.arrow_forward_ios_rounded,
                    //             //   color: Colors.black,
                    //             // ),
                    //           ],
                    //         ),
                    //       )),

                    //   //  )
                    // ),
                  ])
                  //),
                  )
            ])));
  }
}
