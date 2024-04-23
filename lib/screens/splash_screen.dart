
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premier_cms/screens/dashboard.dart';
import 'package:premier_cms/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstRouter();
  }

  void firstRouter()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('loginedUserid');
    email == null ?Future.delayed(const Duration(milliseconds:3500 ), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> MyHomePage())
      );
    }):Future.delayed(const Duration(milliseconds:3500 ), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> DashBoard())
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    double _height =MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: _height,
          width: _width,
          alignment: Alignment.center,
          child: Hero(
            tag: 'logo',
            child: Container(
              height: 200.0,
              child: Image.asset('assets/images/Premier-Logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
