import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_and_signup_web/Model/CustPerShipLU.dart';
import 'package:login_and_signup_web/ShipDetails.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BillableActivity.dart';
import 'CrewChange.dart';
import 'DataSheetPage.dart';
import 'Model/CustPerson.dart';
import 'Model/ListVoyFiles.dart';
import 'SOFActivity.dart';
import 'main.dart';

// ignore: must_be_immutable
class OpenVoyageFilesScreen extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;
  OpenVoyageFilesScreen(CustPerson custPerson, int cqmID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = cqmID;
  }

  @override
  State<StatefulWidget> createState() {
    return OpenVoyageFilesScreenState();
  }
}

class Constants {
  static const String SignOut = 'SIGN OUT';
  static const List<String> choices = [SignOut];
}

class OpenVoyageFilesScreenState extends State<OpenVoyageFilesScreen> {
  Future<List<CustPerShipLU>> custPerShipLU;
  List<ListVoyFiles> voyageFiles;
  String urlIP = "https://192.168.1.19:45455";
  bool search = false;
  void initState() {
    super.initState();
    custPerShipLU = getAllCustPerShipFiles(widget.custPerson.custPersonID);
    getAllVoyageFiles(widget.custPerson.custPersonID);
  }

  void choiceAction(String choice) {
    if (choice == Constants.SignOut) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Future<List<CustPerShipLU>> getAllCustPerShipFiles(int custID) async {
    try {
      var result =
          await http.get(Uri.parse(urlIP + '/api/CustPerShipLU/$custID'));

      if (result.statusCode == 200) {
        var t = (json.decode(result.body) as List);
        var c = t.map((i) => CustPerShipLU.fromJson(i));

        List<CustPerShipLU> custShip = c.toList();
        return custShip;
      } else {
        throw Exception('Failed to custperLU  files');
      }
    } catch (Exception) {
      print(Exception.toString());
      print('Failed to fetch custperLU.Conection failed!');
      return null;
    }
  }

  void getAllVoyageFiles(int custID) async {
    List<CustPerShipLU> tmp = await custPerShipLU;
    List<ListVoyFiles> tmpx = [];
    try {
      for (CustPerShipLU file in tmp) {
        var result = await http.get(
            Uri.parse(urlIP + '/api/ListVoyFile/Vessel/open/${file.vesselID}'));
        if (result.statusCode == 200) {
          var t = (json.decode(result.body) as List);
          var c = t.map((i) => ListVoyFiles.fromJson(i));

          List<ListVoyFiles> tmpFiles = c.toList();
          for (ListVoyFiles file in tmpFiles) tmpx.add(file);
        } else {
          throw Exception('Failed to fetch voyage files');
        }
      }
      setState(() {
        this.voyageFiles = tmpx;
      });
    } catch (Exception) {
      print(Exception.toString());
      print('Failed to fetch voyage files.Connection not established!');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(35.0), // here the desired height
            child: new AppBar(
              title: Text('OPEN VOYAGE FILES'),
              actions: <Widget>[
                PopupMenuButton<String>(
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
                )
              ],
            )),
        body: Row(children: [
          Expanded(
            flex: 2,
            child: new Scaffold(
                backgroundColor: kPrimaryColor1,
                appBar: new PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: new Container(
                    color: kPrimaryColor1,
                    child: Scrollbar(
                      child: ListView(children: [
                        Container(
                          height: 80,
                          width: 40,
                          color: Colors.white,
                          child: ListTile(
                              title: Text(
                                'Search',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              trailing: Icon(Icons.search),
                              onTap: () => {
                                    showSearch(
                                        context: context,
                                        delegate: DataSearch(
                                            voyageFiles,
                                            widget.custQuoteMasterID,
                                            widget.custPerson))
                                  }),
                        ),
                      ]),
                    ),
                  ),
                ),
                body: // Column(
                    //children: [
                    //FloatingSearchBar(),
                    VoyFilePageWidget(widget.custPerson, voyageFiles,
                        widget.custQuoteMasterID)
                //  ],
                //)
                ),
          ),
          Expanded(
              flex: 8,
              child: SizedBox(
                child: DisplayVoyageFilesScreen(
                    widget.custPerson, widget.custQuoteMasterID),
              ))
        ]));
  }
}

// ignore: must_be_immutable
class DisplayVoyageFilesScreen extends StatefulWidget {
  CustPerson custPerson;
  int custQuoteMasterID;

  DisplayVoyageFilesScreen(CustPerson custPerson, int custQuoteMasterID) {
    this.custPerson = custPerson;
    this.custQuoteMasterID = custQuoteMasterID;
  }

  @override
  State<StatefulWidget> createState() {
    return DisplayVoyageFilesScreenState();
  }
}

class DisplayVoyageFilesScreenState extends State<DisplayVoyageFilesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: new Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              color: Colors.white,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      tabs: [
                        new Text("SHIP DETAILS",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        new Text(
                          "DATA SHEET",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        new Text("BILLABLE ACTIVITIES",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        new Text("SOF ACTIVITIES",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        new Text("CREW CHANGE\nCTM DELIVERY",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              ShipDetails(widget.custPerson, widget.custQuoteMasterID),
              DataSheetPageWidget(widget.custPerson, widget.custQuoteMasterID),
              BillableActivityWidget(
                  widget.custPerson, widget.custQuoteMasterID),
              SOFActivityWidget(widget.custPerson, widget.custQuoteMasterID),
              CrewChangeWidget(widget.custPerson, widget.custQuoteMasterID),
            ],
          ),
        ));
  }
}

class DataSearch extends SearchDelegate<String> {
  CustPerson custPerson;
  int custQuoteMasterID;
  List<ListVoyFiles> files;
  ListVoyFiles currentFile;
  List<String> daRefs = [];
  String urlIP = "https://192.168.1.9:45455";
  //List<String> daRefs;
  DataSearch(
      List<ListVoyFiles> files, int custQuoteMasterID, CustPerson custPerson) {
    this.custPerson = custPerson;
    this.files = files;
    this.custQuoteMasterID;
    getAllDARefs();
  }

  Future<String> getVoyFileDARef(int custQuoteMasterID) async {
    try {
      var result = await http
          .get(Uri.parse(urlIP + '/api/ListVoyFile/$custQuoteMasterID'));
      if (result.statusCode == 200) {
        ListVoyFiles file = ListVoyFiles.fromJson(jsonDecode(result.body));
        return file.dareference;
      } else {
        throw Exception('Failed to fetch DA Reference');
      }
    } catch (Exception) {
      print(Exception.toString());
    }
    return null;
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  void getAllDARefs() async {
    for (int i = 0; i < files.length; i++) {
      this.daRefs.add(files.elementAt(i).dareference);
    }
  }

  void getFile(int index) async {
    currentFile = files.elementAt(index);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {
    //show result based on selection
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    //when someone searches for something

    final suggestionList = query.isEmpty
        ? daRefs
        : daRefs.where((e) => e.contains(query.toUpperCase())).toList();

    return suggestionList.isEmpty
        ? Text(
            'No such file found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          )
        : ListView.builder(
            //shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
                onTap: () {
                  getFile(index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OpenVoyageFilesScreen(
                                custPerson,
                                currentFile.custQuoteMasterID,
                              )));
                },
                leading: Icon(Icons.insert_drive_file_sharp),
                title: RichText(
                  text: TextSpan(
                    children:
                        highlightOccurrences(suggestionList[index], query),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                )),
            itemCount: suggestionList.length,
          );
  }
}

// ignore: must_be_immutable
class VoyFilePageWidget extends StatefulWidget {
  CustPerson custPerson;
  int selectedCustQuoteMasterID;
  List<ListVoyFiles> files;
  VoyFilePageWidget(CustPerson custPerson, List<ListVoyFiles> files,
      int selectedCustQuoteMasterID) {
    this.custPerson = custPerson;
    this.files = files;
    this.selectedCustQuoteMasterID = selectedCustQuoteMasterID;
  }
  @override
  _VoyFilePageWidgetState createState() => _VoyFilePageWidgetState();
}

class _VoyFilePageWidgetState extends State<VoyFilePageWidget> {
  Widget displayAllVoyFilesWidget() {
    return Expanded(
        child: ListView.builder(
      itemCount: (widget.files == null) ? 0 : widget.files.length,
      itemBuilder: (BuildContext context, int index) {
        ListVoyFiles file = widget.files.elementAt(index);
        return VoyFileListViewWidget(
            widget.custPerson,
            file,
            (widget.selectedCustQuoteMasterID != null &&
                file.custQuoteMasterID == widget.selectedCustQuoteMasterID));
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      displayAllVoyFilesWidget(),
    ]);
  }
}

// ignore: must_be_immutable
class VoyFileListViewWidget extends StatefulWidget {
  ListVoyFiles file;
  CustPerson custPerson;
  bool selected = false;
  VoyFileListViewWidget(
      CustPerson custPerson, ListVoyFiles file, bool selected) {
    this.custPerson = custPerson;
    this.file = file;
    this.selected = selected;
  }
  @override
  _VoyFileListViewWidgetState createState() => _VoyFileListViewWidgetState();
}

class _VoyFileListViewWidgetState extends State<VoyFileListViewWidget> {
  String DARef;
  int custQuoteMasterID;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      color: (widget.selected) ? kPrimaryColor2 : Colors.white,
      child: ListTile(
        title: Text(
          '${widget.file.dareference}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OpenVoyageFilesScreen(
                      widget.custPerson, widget.file.custQuoteMasterID)));
        },
      ),
    );
  }
}
