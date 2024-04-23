

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:premier_cms/components/form_feild.dart';
import 'package:premier_cms/screens/form_page.dart';
import 'package:premier_cms/screens/home_page.dart';
import 'package:premier_cms/screens/local_orders.dart';
import 'package:premier_cms/screens/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override

  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> _pages = [FormPage(),LocalOrders(),UserProfile()];
  Widget _getCurrentPage() => _pages[_currentPageIndex];
  int _currentPageIndex=0;
  bool backEn=false;


  @override
  Widget build(BuildContext context) {
    double _height =MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff77787b),
      body: _getCurrentPage(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:Colors.white,
        // index: _currentPageIndex,
        color: const Color(0xff3E4684),
        height: 60,
        items:  <Widget>[
          Icon(Icons.add, size:25,color: Colors.white),
          Icon(Icons.list, size: 25,color: Colors.white),
          Icon(Icons.person, size: 25,color: Colors.white),
        ],
        animationDuration: const Duration(
            milliseconds: 100
        ),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}



