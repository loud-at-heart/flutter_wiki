import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wiki/Model/recent.dart';
import 'package:flutter_wiki/Model/wiki.dart';
import 'package:flutter_wiki/Screens/mainPage.dart';
import 'package:flutter_wiki/Services/searchList.dart';
import 'package:flutter_wiki/Services/share.dart';
import 'package:flutter_wiki/Widgets/shimmer_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  final String subString;
  const SearchPage({Key? key, required this.subString}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CatalogService catalogService = CatalogService();
  WikiModel results = WikiModel();
  TextEditingController _searchController = TextEditingController();
  String query = '';
  List<Recents> list = [];
  SharedPreferences? sharedPreferences;

  void searchWiki(String query, bool onSubmitted) async {
    var infoData = await catalogService.searchWiki(query, onSubmitted);
    WikiModel infoFetched = WikiModel.fromJson(infoData);
    setState(() {
      results = infoFetched;
    });
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPreferencesAndData();
    if(widget.subString != ''){
      _searchController.text=widget.subString;
      setState(() {
        query = _searchController.text;
      });
      searchWiki(query, true);
    }
    super.initState();
  }

  void loadData() {
    //Loading the results data and mapping them to List of Type "Result"
    List<String>? listString = sharedPreferences!.getStringList('list');
    if (listString != null) {
      setState(() {
        list = listString
            .map((item) => Recents.fromMap(json.decode(item)))
            .toList();
      });
    } else {
      list = [];
    }
  }

  void loadSharedPreferencesAndData() async {
    //Initializing the shared preferences
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  addItem(Recents item) {
    //Adding the item to the recents
    if (list.isEmpty || list[0].title != item.title) {
      list.insert(0, item);
    }
    saveData();
  }

  void saveData() {
    //Saving the recents data in the shared preferences
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences!.setStringList('list', stringList);
    print('Items Saved');
  }

  @override
  Widget build(BuildContext context) {
    var searchResultData = results.query;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        textTheme: Theme.of(context).textTheme,
        toolbarHeight: 175.0,
        elevation: 0.0,
        bottom: PreferredSize(
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                  child: SvgPicture.asset('assets/images/Back.svg'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainPage()));
                  },
                ),
                title: Text(
                  "Search...",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xff5E56E7),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color(0xFFA0A0A0),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F0F6),
                    focusColor: Color(0xFFF0F0F6),
                    prefixIcon: Hero(
                      tag: 'search',
                      child: SvgPicture.asset(
                        'assets/images/Search.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    suffixIcon: query.isNotEmpty
                        ? InkWell(
                            child: SvgPicture.asset(
                              'assets/images/Cancel.svg',
                              fit: BoxFit.none,
                            ),
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                query = '';
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      // results.clear();
                      results = WikiModel();
                      query = '';
                      query = value;
                    });
                    query.isEmpty ? print('Empty') : searchWiki(query, false);
                    // query.isEmpty ? print('Empty') : print(query);
                  },
                  onSubmitted: (value) {
                    setState(() {
                      // results.clear();
                      results = WikiModel();
                      query = value;
                    });
                    query.isEmpty ? print('Empty') : searchWiki(query, true);
                    addItem(Recents(title: query));
                    // query.isEmpty ? print('Empty') : print(query);
                  },
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(175),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(10),
            height: height * 0.7,
            child: query.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Image(
                          image: AssetImage("assets/images/welcome.webp"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Type to Search ...",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ],
                  )
                : results.query != null
                    ? ListView.builder(
                        itemCount: results.query!.pages!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              // color: DynamicColor().getColor(1.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  onLongPress: () {
                                    HapticFeedback.heavyImpact();
                                    share(
                                        context,
                                        searchResultData!.pages![index].extract,
                                        searchResultData.pages![index].url);
                                  },
                                  onTap: () {
                                    launchURL(
                                        searchResultData!.pages![index].url);
                                  },
                                  tileColor: Colors.white,
                                  contentPadding: EdgeInsets.all(8.0),
                                  leading: searchResultData!
                                              .pages![index].thumbnail !=
                                          null
                                      ? searchResultData.pages![index] != null
                                          ? CacheImage(
                                              url: searchResultData
                                                  .pages![index]
                                                  .thumbnail!
                                                  .source,
                                            )
                                          : Image.asset(
                                              "assets/images/wiki.png")
                                      : Image.asset(
                                          "assets/images/wiki.png",
                                          scale: 8,
                                          height: 80,
                                          width: 80,
                                        ),
                                  subtitle: Text(
                                    searchResultData.pages![index].terms != null
                                        ? searchResultData.pages![index].terms!
                                            .description![0]
                                        : "Description not available",
                                  ),
                                  title: Text(
                                    results.query!.pages![index].title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                          );
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
                      )),
      ),
    );
  }
}
