import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wiki/Model/browse.dart';
import 'package:flutter_wiki/Model/recent.dart';
import 'package:flutter_wiki/Screens/searchPage.dart';
import 'package:flutter_wiki/Services/searchList.dart';
import 'package:flutter_wiki/Utils/checkConnectivity.dart';
import 'package:flutter_wiki/Widgets/bottom_sheet_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CatalogService catalogService = CatalogService();
  VoidCallback? _showBottomSheetCallback;
  VoidCallback? _hideBottomSheetCallback;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetOpen = false;
  List<Recents> list = <Recents>[];
  List<Browse> browseList = <Browse>[];
  SharedPreferences? sharedPreferences;
  bool? isConnected;
  MyConnectivity _connectivity = MyConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (mounted) {
        setState(() => _source = source);
      }
    });
    _showBottomSheetCallback = _showPersistentBottomSheet;
    _hideBottomSheetCallback = _hidePersistentBottomSheet;
    loadSharedPreferencesAndData();
  }

  void loadData() {
    //Loading the reselts data and mapping them to List of Type "Result"
    List<String>? listString = sharedPreferences!.getStringList('list');
    if (listString != null) {
      setState(() {
        list = listString
            .map((item) => Recents.fromMap(json.decode(item)))
            .toList();
      });
    } else {
      list = <Recents>[];
    }
    //Loading the reselts data and mapping them to List of Type "Browse"
    List<String>? browseListString =
        sharedPreferences!.getStringList('browseList');
    if (browseListString != null) {
      setState(() {
        browseList = browseListString
            .map((item) => Browse.fromMap(json.decode(item)))
            .toList();
      });
    } else {
      browseList = [];
    }
  }

  removeData(String key) async {
    //Remove specific shared pref key
    await sharedPreferences!.remove(key);
    loadData();
  }

  removeSpecificData(String value) async {
    //Remove specific
    var toRemove = [];
    list.forEach((element) {
      if (element.title == value) {
        print('${element.title} is found');
        toRemove.add(element);
      }
    });
    list.removeWhere((e) => toRemove.contains(e));
    saveData();
    loadData();
  }

  removeBrowseSpecificData(Browse value) async {
    //Remove specific
    var toRemove = [];
    browseList.forEach((element) {
      if (element.title == value.title) {
        print('${element.title} is found');
        toRemove.add(element);
      }
    });
    browseList.removeWhere((e) => toRemove.contains(e));
    saveBrowseData();
    loadData();
  }

  void saveBrowseData() {
    //Saving the recents data in the shared preferences
    List<String> stringList =
        browseList.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences!.setStringList('browseList', stringList);
    print('Browsing Items Saved');
  }

  void loadSharedPreferencesAndData() async {
    //Initializing the shared preferences
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData() {
    //Saving the recents data in the shared preferences
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences!.setStringList('list', stringList);
    print('Items Saved');
  }

  void _showPersistentBottomSheet() {
    setState(() {
      // Make the isBottomSheetOpen true
      isBottomSheetOpen = true;
      // Disable the show bottom sheet button.
      _showBottomSheetCallback = null;
      loadData();
    });

    _scaffoldKey.currentState!
        .showBottomSheet<void>(
          (context) {
            return BottomSheetContent(
              removeRecent: (value) => removeData(value),
              service: catalogService,
              recentList: list,
              browseList: browseList,
              loadList: () => loadSharedPreferencesAndData(),
              removeSpecificItem: (value) => removeSpecificData(value),
              removeBrowseSpecificItem: (value) =>
                  removeBrowseSpecificData(value),
              isConnected: isConnected!,
            );
          },
          elevation: 25,
        )
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // Re-enable the bottom sheet button.
              _showBottomSheetCallback = _showPersistentBottomSheet;
              isBottomSheetOpen = false;
            });
          }
        });
  }

  void _hidePersistentBottomSheet() {
    setState(() {
      isBottomSheetOpen = false;
    });
    Navigator.of(context).pop();
  }

  void showInSnackBar(String value) {
    final snackBar = new SnackBar(
        content: new Text(value),
        backgroundColor: isConnected! ? Colors.green : Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void connection(){
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          isConnected = false;
        });
        // WidgetsBinding.instance!.addPostFrameCallback(
        //     (_) => showInSnackBar('Internet Not Connected'));
        break;
      case ConnectivityResult.mobile:
        setState(() {
          isConnected = true;
        });
        // WidgetsBinding.instance!.addPostFrameCallback(
        //         (_) => showInSnackBar('Mobile Internet Connected'));
        break;
      case ConnectivityResult.wifi:
        setState(() {
          isConnected = true;
        });
        // WidgetsBinding.instance!.addPostFrameCallback(
        //         (_) => showInSnackBar('Wifi Internet Connected'));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    connection();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffF8F7FF),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      width: width,
                      // color: Colors.amber,
                      child: Hero(
                        tag: 'Pattern',
                        child: SvgPicture.asset(
                          "assets/images/Pattern.svg",
                          fit: BoxFit.cover,
                          height: 350,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100,
                      top: 10,
                      child: Container(
                        // height: 250.0,
                        width: width,
                        // color: Colors.amber,
                        child: Image.asset(
                          "assets/images/wiki.png",
                          // fit: BoxFit.scaleDown,
                          height: 170,
                          width: 170,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            tag: 'Flutter',
                            child: Text(
                              'Flutter',
                              style: kHeadingOne,
                            ),
                          ),
                          Hero(
                            tag: 'Wiki',
                            child: Text(
                              'Wiki',
                              style: kHeadingOne,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            kDesc,
                            maxLines: 3,
                            style: kBody,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                isConnected!
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(
                                subString: '',
                                isConnected: isConnected!,
                              ),
                            ),
                          );
                        },
                        child: AvatarGlow(
                          glowColor: Colors.blue,
                          endRadius: 90.0,
                          duration: Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration: Duration(milliseconds: 100),
                          child: Material(
                            // Replace this child with your own
                            elevation: 8.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Hero(
                                tag: 'search',
                                child: SvgPicture.asset(
                                  'assets/images/Search.svg',
                                  fit: BoxFit.none,
                                ),
                              ),
                              radius: 30.0,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: height * 0.3,
                        child: Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              'assets/images/noInternet.svg',
                              fit: BoxFit.scaleDown,
                              height: 50.0,
                              width: 50.0,
                            ),
                            radius: 30.0,
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isConnected! ? kSearch : kSearchNoInternet,
                    maxLines: 3,
                    style: kHeadingTwo.copyWith(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: isBottomSheetOpen
              ? _hideBottomSheetCallback
              : _showBottomSheetCallback,
          child: isBottomSheetOpen
              ? SvgPicture.asset(
                  'assets/images/Back.svg',
                  color: Colors.white,
                )
              : Icon(
                  Icons.history_rounded,
                  size: 40,
                ),
        ),
        floatingActionButtonLocation: isBottomSheetOpen
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat);
  }
}
