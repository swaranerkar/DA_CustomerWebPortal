import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:intl/intl.dart';
import 'Model/CustPerson.dart';
import 'Model/ListBillActTrans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class BillableActivityWidget extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;
  BillableActivityWidget(CustPerson custPerson, int custQuoteMasterID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = custQuoteMasterID;
  }
  @override
  _BillableActivityWidgetState createState() => _BillableActivityWidgetState();
}

class _BillableActivityWidgetState extends State<BillableActivityWidget> {
  Future<List<ListBillActTrans>> activities;
  final dateFormat = new DateFormat('dd-MM-yyyy');
  List<ListBillActTrans> list;
  int i = 1;
  String urlIP = "https://192.168.1.19:45455";
  void initState() {
    super.initState();
    i = 1;

    setState(() {
      if (widget.custQuoteMasterID != null) activities = getAllActivities();
    });
  }

  Future<List<ListBillActTrans>> getAllActivities() async {
    try {
      int cqmID = widget.custQuoteMasterID;
      var result =
          await http.get(Uri.parse(urlIP + '/api/ListBillActTrans/$cqmID'));
      if (result.statusCode == 200) {
        List<ListBillActTrans> activities = (json.decode(result.body) as List)
            .map((i) => ListBillActTrans.fromJson(i))
            .toList();
        setState(() {
          list = activities;
        });

        return activities;
      } else {
        throw Exception('Failed to load');
      }
    } catch (Exception) {
      print(Exception.toString());
      print('Could not fetch all saved activities.Conection failed!');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    i = 1;
    return Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            (widget.custQuoteMasterID == null)
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "NO VOYAGE FILE SELECTED. PLEASE SELECT A FILE TO VIEW DETAILS.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ))
                : Container(),
            Card(
              margin: EdgeInsets.all(10),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: kPrimaryColor1,
              child: Container(
                width: 2000,
                child: Text(
                  "BILLABLE ACTIVITIES",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              //margin: EdgeInsets.all(10),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: 2000,
                child: DataTable(
                    showBottomBorder: true,

                    //dataRowHeight: 70,
                    columnSpacing: 0,
                    headingRowHeight: 65,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Sr. No',
                          overflow: TextOverflow.ellipsis,
                          // strutStyle: StrutStyle.
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Activity Type',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Vendor',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Quantity',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Units',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Remarks',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: (list == null)
                        ? [] //List(0)
                        : list
                            .map((e) => DataRow(cells: [
                                  DataCell(Text((i++).toString())),
                                  // DataCell(Text(e.vendorName)),
                                  DataCell(Text(dateFormat
                                      .format(DateTime.parse(e.cqmtransDate)))),
                                  DataCell(Text(e.cqmtransTypeDesc)),
                                  DataCell(Text(e.vendorName)),
                                  DataCell(Text(e.qty.toString())),
                                  DataCell(Text(e.unitsDesc)),
                                  DataCell(Text(e.transStatus)),
                                  DataCell(Text(e.cqmpurpose)),
                                ]))
                            .toList()),
              ),
            ),
          ],
        ));
  }
}
