import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wiki/Screens/searchPage.dart';

import '../Constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    child: SvgPicture.asset(
                      "assets/images/Pattern.svg",
                      fit: BoxFit.cover,
                      height: 350,
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
                    padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Flutter',
                          style: kHeadingOne,
                        ),
                        Text(
                          'Wiki',
                          style: kHeadingOne,
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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchPage()));
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  kSearch,
                  maxLines: 3,
                  style: kHeadingTwo.copyWith(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
