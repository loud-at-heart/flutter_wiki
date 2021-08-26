import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wiki/Constants.dart';
import 'package:flutter_wiki/Model/browse.dart';
import 'package:flutter_wiki/Model/recent.dart';
import 'package:flutter_wiki/Screens/searchPage.dart';
import 'package:flutter_wiki/Services/searchList.dart';
import 'package:flutter_wiki/Services/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetContent extends StatefulWidget {
  final CatalogService service;
  final List<Recents> recentList;
  final List<Browse> browseList;
  final Function removeRecent;
  final Function loadList;
  final Function(String) removeSpecificItem;

  const BottomSheetContent({
    Key? key,
    required this.service,
    required this.recentList,
    required this.removeRecent,
    required this.loadList,
    required this.removeSpecificItem,
    required this.browseList,
  }) : super(key: key);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  void initState() {
    widget.loadList;
    super.initState();
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          ListTile(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'HISTORY',
                  textAlign: TextAlign.center,
                  style: kHeadingTwo.copyWith(letterSpacing: 2.0),
                ),
              ),
            ),
            trailing: ClipOval(
              child: Material(
                color: Colors.red, // Button color
                child: InkWell(
                  splashColor: Colors.red.shade800, // Splash color
                  onTap: () {
                    setState(() {
                      widget.removeRecent();
                      widget.loadList();
                      widget.recentList.clear();
                      widget.service.deleteAllCache();
                    });
                  },
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Icon(
                      FontAwesomeIcons.broom,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
            width: 150.0,
            child: Divider(
              color: Colors.teal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.47,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: TabBar(
                    onTap: (index) {
                      print(index);
                    },
                    tabs: [
                      Tab(
                        child: Text(
                          'SEARCH',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3.0,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'BROWSING',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      widget.recentList.isNotEmpty
                          ? ListView.builder(
                              itemCount: widget.recentList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.history_rounded),
                                  title: InkWell(
                                    child: Text(widget.recentList[index].title),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SearchPage(
                                            subString:
                                                widget.recentList[index].title,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  trailing: InkWell(
                                    child: Icon(Icons.clear),
                                    onTap: () {
                                      var infoName = widget.recentList[index];
                                      setState(() {
                                        widget.service.deleteSpecificCache(
                                            infoName.title);
                                        widget.loadList();
                                        widget
                                            .removeSpecificItem(infoName.title);
                                        widget.recentList.remove(infoName);
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          : Column(
                              children: [
                                Image.asset(
                                  "assets/images/loading.gif",
                                  height: 250.0,
                                  width: 250.0,
                                ),
                                Text(
                                  'Search something...',
                                  style: kBody,
                                ),
                              ],
                            ),
                      ListView.builder(
                          itemCount: widget.browseList.length,
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
                                          widget.browseList[index].extract,
                                          widget.browseList[index].url);
                                    },
                                    onTap: () {
                                      launchURL(
                                          widget.browseList[index].url);
                                    },
                                    tileColor: Colors.white,
                                    contentPadding: EdgeInsets.all(8.0),
                                    leading: Image.asset(
                                      "assets/images/wiki.png",
                                      scale: 8,
                                      height: 80,
                                      width: 80,
                                    ),
                                    subtitle: Text(
                                        widget.browseList[index].desc,
                                    ),
                                    title: Text(
                                      widget.browseList[index].title,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    isThreeLine: true,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
