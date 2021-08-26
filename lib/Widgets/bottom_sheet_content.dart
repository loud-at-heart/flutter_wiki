import 'package:flutter/material.dart';
import 'package:flutter_wiki/Constants.dart';
import 'package:flutter_wiki/Model/recent.dart';
import 'package:flutter_wiki/Screens/searchPage.dart';
import 'package:flutter_wiki/Services/searchList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetContent extends StatefulWidget {
  final CatalogService service;
  final List<Recents> recentList;
  final Function removeRecent;
  final Function loadList;

  const BottomSheetContent(
      {Key? key,
      required this.service,
      required this.recentList,
      required this.removeRecent,
      required this.loadList})
      : super(key: key);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  void initState() {
    // widget.loadList;
    super.initState();
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
          widget.recentList.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: widget.recentList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.recentList[index].title),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SearchPage(
                                subString: widget.recentList[index].title,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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
        ],
      ),
    );
  }
}
