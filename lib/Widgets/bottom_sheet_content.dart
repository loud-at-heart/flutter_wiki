import 'package:flutter/material.dart';
import 'package:flutter_wiki/Model/recent.dart';
import 'package:flutter_wiki/Screens/searchPage.dart';
import 'package:flutter_wiki/Services/searchList.dart';


class BottomSheetContent extends StatefulWidget {
  final CatalogService service;
  final List<Recents> recentList;
  final Function removeRecent;
  final Function loadList;

  const BottomSheetContent({Key? key, required this.service, required this.recentList, required this.removeRecent, required this.loadList}) : super(key: key);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {

  @override
  void initState() {
    widget.loadList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Center(
              child: Text(
                'History',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: widget.recentList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.recentList[index].title),
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SearchPage(subString: widget.recentList[index].title,)));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
