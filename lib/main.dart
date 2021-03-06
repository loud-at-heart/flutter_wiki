import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/mainPage.dart';
import 'dart:async';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wiki',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff5E56E7),
        buttonColor: Color(0xff5E56E7),
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xff5E56E7),
          unselectedLabelColor: Colors.grey,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            ),
          ),
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xff5E56E7)),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // darkTheme: ThemeData.dark().copyWith(
      //   primaryColor: Color(0xff5E56E7),
      //   textTheme: GoogleFonts.ubuntuTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),
      // themeMode: ThemeController.to.themeMode,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  // bool? isConnected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    Timer(
        Duration(seconds: 2),
        () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()))
            });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: newheight,
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
            Container(
              padding: EdgeInsets.all(20.0),
              height: double.infinity,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeTransition(
                    opacity: animation,
                    child: Hero(
                      tag: 'Flutter',
                      child: Text(
                        'Flutter',
                        style: TextStyle(
                          fontSize: 48.0,
                          color: Color(0xff5E56E7),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: animation,
                    child: Hero(
                      tag: 'Wiki',
                      child: Text(
                        'Wiki',
                        style: TextStyle(
                          fontSize: 48.0,
                          color: Color(0xff5E56E7),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
