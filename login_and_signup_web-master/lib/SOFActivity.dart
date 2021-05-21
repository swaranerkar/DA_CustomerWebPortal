import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Model/CustPerson.dart';
import 'Model/SOFMaster.dart';
import 'Model/SOFTrans.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SOFActivityWidget extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;

  SOFActivityWidget(CustPerson custPerson, int custQuoteMasterID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = custQuoteMasterID;
  }

  @override
  _SOFActivityWidgetState createState() => _SOFActivityWidgetState();
}

class _SOFActivityWidgetState extends State<SOFActivityWidget> {
  Future<List<SOFTrans>> activities;
  final dateFormat = new DateFormat('dd-MM-yyyy');
  List<SOFTrans> list;
  String urlIP = "https://192.168.1.19:45455";
  int i = 1;
  void initState() {
    super.initState();
    setState(() {
      i = 1;
      if (widget.custQuoteMasterID != null) {
        activities = getAllSOFActivities();
      }
    });
  }

  Future<List<SOFTrans>> getAllSOFActivities() async {
    try {
      var result = await http
          .get(Uri.parse(urlIP + '/api/Softran/${widget.custQuoteMasterID}'));

      if (result.statusCode == 200) {
        List<SOFTrans> activities = (json.decode(result.body) as List)
            .map((i) => SOFTrans.fromJson(i))
            .toList();
        setState(() {
          list = activities;
        });
        fetchTypeDesc();
        return activities;
      } else {
        throw Exception('Failed to load');
      }
    } catch (Exception) {
      print('Could not fetch all saved SOF activities.Connection failed!');
      return null;
    }
  }

  void fetchTypeDesc() async {
    List<SOFTrans> tmp = this.list;
    for (SOFTrans act in tmp) {
      String url = urlIP + '/api/Sofmaster/${act.sofmasterID}';
      http.Response res = await http.get(Uri.parse(url));
      print(res.statusCode);
      SOFMaster sofMaster = SOFMaster.fromJson(jsonDecode(res.body));
      act.sofmasterDesc = sofMaster.softype;
    }
    setState(() {
      this.list = tmp;
    });
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center))
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
                "SOF ACTIVITIES",
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              width: 3000,
              child: DataTable(
                  showBottomBorder: true,
                  headingRowHeight: 65,
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Sr. No',
                        overflow: TextOverflow.ellipsis,
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
                        'Remarks',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: (list == null)
                      ? []
                      : list
                          .map((e) => DataRow(cells: [
                                DataCell(Text((i++).toString())),
                                DataCell(Text(dateFormat
                                    .format(DateTime.parse(e.softransDate)))),
                                DataCell(Text((e.sofmasterDesc != null)
                                    ? e.sofmasterDesc
                                    : "")),
                                DataCell(Text(e.softransRemarks)),
                              ]))
                          .toList()),
            ),
            // )),
          )
        ],
      ),
    );
  }
}
