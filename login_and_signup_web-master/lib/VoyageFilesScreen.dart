import 'dart:html';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_and_signup_web/ShipDetails.dart';
import 'package:login_and_signup_web/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BillableActivity.dart';
import 'CrewChange.dart';
import 'DataSheetPage.dart';
import 'Model/ListVoyFiles.dart';
import 'Model/UserDetails.dart';
import 'Model/VoyFileLookUp.dart';
import 'SOFActivity.dart';
import 'main.dart';

// ignore: must_be_immutable
class VoyageFilesScreen extends StatefulWidget {
  int custQuoteMasterID;
  UserDetails userDetails;

  VoyageFilesScreen(
    UserDetails userDetails,
    int custQuoteMasterID,
  ) {
    this.custQuoteMasterID = custQuoteMasterID;
    this.userDetails = userDetails;
  }

  @override
  State<StatefulWidget> createState() {
    return VoyageFilesScreenState();
  }
}

class Constants {
  static const String SignOut = 'SIGN OUT';
  static const List<String> choices = [SignOut];
}

class VoyFileSearchResult {
  //int custQuoteMasterID;
  String dareference;
  VoyFileSearchResult(
      // this.custQuoteMasterID,
      this.dareference);
}

class VoyageFilesScreenState extends State<VoyageFilesScreen> {
  Future<List<VoyFileLookUp>> files;
  bool search = false;
  void initState() {
    super.initState();
    files = getAllVoyFiles(widget.userDetails.userID);
  }

  Future<List<VoyFileLookUp>> getAllVoyFiles(int userID) async {
    try {
      var result = await http.get(
          Uri.parse('https://192.168.1.106:45455/api/VoyFileLookUp/$userID'));

      if (result.statusCode == 200) {
        var t = (json.decode(result.body) as List);
        var c = t.map((i) => VoyFileLookUp.fromJson(i));

        List<VoyFileLookUp> voyFiles = c.toList();
        return voyFiles;
      } else {
        throw Exception('Failed to load voyage files');
      }
    } catch (Exception) {
      print(Exception.toString());
      print('Failed to fetch voyage files.Conection failed!');
      return null;
    }
  }

  // void useSearchBar() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
  //         this.search = true;
  //       }));
  // }

  void choiceAction(String choice) {
    if (choice == Constants.SignOut) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(35.0), // here the desired height
            child: new AppBar(
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  icon: Icon(Icons.menu, color: Colors.white),
                  //child: Text("OPTIONS"),
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
                                      delegate:
                                          DataSearch(files, widget.userDetails))
                                }),
                      ),
                    ]),
                  ),
                ),
              ),
              body: // Column(
                  //children: [
                  //FloatingSearchBar(),
                  VoyFilePageWidget(
                      widget.userDetails, files, widget.custQuoteMasterID),
              //  ],
              //)
            ),
          ),
          Expanded(
              flex: 8,
              child: SizedBox(
                child: DisplayVoyageFilesScreen(
                    widget.userDetails, widget.custQuoteMasterID),
              ))
        ]));
  }
}

// ignore: must_be_immutable
class DisplayVoyageFilesScreen extends StatefulWidget {
  UserDetails userDetails;
  int custQuoteMasterID;

  DisplayVoyageFilesScreen(UserDetails userDetails, int custQuoteMasterID) {
    this.userDetails = userDetails;
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
              ShipDetails(widget.userDetails, widget.custQuoteMasterID),
              DataSheetPageWidget(widget.userDetails, widget.custQuoteMasterID),
              BillableActivityWidget(
                  widget.userDetails, widget.custQuoteMasterID),
              SOFActivityWidget(widget.userDetails, widget.custQuoteMasterID),
              CrewChangeWidget(widget.userDetails, widget.custQuoteMasterID),
            ],
          ),
        ));
  }
}

class DataSearch extends SearchDelegate<String> {
  UserDetails userDetails;
  int custQuoteMasterID;
  Future<List<VoyFileLookUp>> files;
  List<VoyFileLookUp> tempf;
  VoyFileLookUp currentFile;
  List<String> daRefs = [];
  //List<String> daRefs;
  DataSearch(Future<List<VoyFileLookUp>> files, UserDetails userDetails) {
    this.userDetails = userDetails;
    this.files = files;
    this.custQuoteMasterID;
    getAllDARefs(files);
  }

  Future<String> getVoyFileDARef(int custQuoteMasterID) async {
    try {
      var result = await http.get(Uri.parse(
          'https://192.168.1.106:45455/api/ListVoyFile/$custQuoteMasterID'));
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

  void getAllDARefs(Future<List<VoyFileLookUp>> files) async {
    List<VoyFileLookUp> xFiles = await files;
    for (int i = 0; i < xFiles.length; i++) {
      VoyFileLookUp f = xFiles.elementAt(i);
      int id = f.custQuoteMasterID;
      String x = await getVoyFileDARef(id);
      this.daRefs.add(x);
    }
  }

  void getFile(int index) async {
    List<VoyFileLookUp> tempf = await files;
    currentFile = tempf.elementAt(index);
    /*setState(() {
      currentFile = tempf.elementAt(index);
    });*/
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
                          builder: (context) => VoyageFilesScreen(
                                userDetails,
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
  UserDetails userDetails;
  int selectedCustQuoteMasterID;
  // ignore: non_constant_identifier_names
  Future<List<VoyFileLookUp>> files;
  VoyFilePageWidget(UserDetails userDetails, Future<List<VoyFileLookUp>> x,
      int selectedCustQuoteMasterID) {
    this.userDetails = userDetails;
    this.files = x;
    this.selectedCustQuoteMasterID = selectedCustQuoteMasterID;
  }
  @override
  _VoyFilePageWidgetState createState() => _VoyFilePageWidgetState();
}

class _VoyFilePageWidgetState extends State<VoyFilePageWidget> {
  Widget displayAllVoyFilesWidget() {
    return FutureBuilder(
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.none &&
            snapShot.hasData == null) {
          return Container();
        }
        return Container(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapShot.data?.length ?? 0,
          itemBuilder: (context, index) {
            VoyFileLookUp file = snapShot.data[index];
            return VoyFileListViewWidget(
                widget.userDetails,
                file,
                (widget.selectedCustQuoteMasterID != null &&
                    file.custQuoteMasterID ==
                        widget.selectedCustQuoteMasterID));
          },
        ));
      },
      future: widget.files,
    );
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
  VoyFileLookUp file;
  UserDetails userDetails;
  bool selected = false;
  VoyFileListViewWidget(
      UserDetails userDetails, VoyFileLookUp file, bool selected) {
    this.userDetails = userDetails;
    this.file = file;
    this.selected = selected;
  }
  @override
  _VoyFileListViewWidgetState createState() => _VoyFileListViewWidgetState();
}

class _VoyFileListViewWidgetState extends State<VoyFileListViewWidget> {
  // ignore: non_constant_identifier_names
  String DARef;
  int custQuoteMasterID;

  void initState() {
    super.initState();
    getVoyFileDARef(widget.file);
  }

  void getVoyFileDARef(VoyFileLookUp f) async {
    int id = f.custQuoteMasterID;
    try {
      var result = await http
          .get(Uri.parse('https://192.168.1.106:45455/api/ListVoyFile/$id'));
      if (result.statusCode == 200) {
        ListVoyFiles file = ListVoyFiles.fromJson(jsonDecode(result.body));
        setState(() {
          this.DARef = file.dareference;
          this.custQuoteMasterID = file.custQuoteMasterID;
        });
      } else {
        throw Exception('Failed to fetch DA Reference');
      }
    } catch (Exception) {
      print(Exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      color: (widget.selected) ? kPrimaryColor2 : Colors.white,
      child: ListTile(
        title: Text(
          '$DARef',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        // leading: Icon(
        //   Icons.insert_drive_file_sharp,
        // ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VoyageFilesScreen(
                      widget.userDetails, custQuoteMasterID)));
        },
      ),
    );
  }
}
