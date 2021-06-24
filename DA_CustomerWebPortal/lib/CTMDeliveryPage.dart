import 'package:flutter/material.dart';
import 'package:login_and_signup_web/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Model/CTMTrans.dart';
import 'Model/CustPerson.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CTMDeliveryWidget extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;
  CTMDeliveryWidget(CustPerson custPerson, int custQuoteMasterID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  _CTMDeliveryWidgetState createState() => _CTMDeliveryWidgetState();
}

class _CTMDeliveryWidgetState extends State<CTMDeliveryWidget> {
  CTMTrans ctmTrans;
  final ctmDeliveryDateController = TextEditingController();
  final ctmamtReqController = TextEditingController();
  final ctmcurrencyController = TextEditingController();
  final ctmdelAmtController = TextEditingController();
  DateTime now;
  DateTime date;
  String urlIP = "https://192.168.1.10:45455";
  void initState() {
    super.initState();

    setState(() {
      now = new DateTime.now();
      date = new DateTime(now.year, now.month, now.day);
      if (widget.custQuoteMasterID != null)
        getCTMInfo(widget.custQuoteMasterID);
    });
  }

  void getCTMInfo(int custQuoteMasterID) async {
    try {
      var result =
          await http.get(Uri.parse(urlIP + '/api/Ctmtran/$custQuoteMasterID'));
      if (result.statusCode == 200) {
        setState(() {
          this.ctmTrans = CTMTrans.fromJson(jsonDecode(result.body));
          DateTime temp = DateFormat("yyyy-MM-dd'T'HH:mm:ss")
              .parse(ctmTrans.ctmdeliveryDate);
          ctmamtReqController.text = ctmTrans.ctmamtReq.toString();
          ctmcurrencyController.text = ctmTrans.ctmcurrency;
          ctmdelAmtController.text = ctmTrans.ctmdelAmt.toString();

          ctmDeliveryDateController.text =
              DateFormat("dd-MM-yyyy").format(temp);
        });
      } else {}
    } catch (Exception) {
      print(Exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Card(
              //margin: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: kPrimaryColor1,
              child: Container(
                width: 2000,
                child: Text(
                  "CTM DELIVERY",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
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
                              'CTM AMOUNT REQUESTED',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: TextField(
                              controller: ctmamtReqController,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                              enabled: false,
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
                              'CTM AMOUNT CURRENCY',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: TextField(
                              controller: ctmcurrencyController,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                              enabled: false,
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
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: kPrimaryColor1,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: 2000,
                child: Text(
                  "CTM DELIVERED",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
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
                              'DELIVERY DATE',
                              overflow: TextOverflow.ellipsis,
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
                              controller: ctmDeliveryDateController,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                              enabled: false,
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
                              'DELIVERY AMOUNT',
                              overflow: TextOverflow.ellipsis,
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
                              controller: ctmdelAmtController,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                              enabled: false,
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
            ),
          ],
        ));
  }
}
