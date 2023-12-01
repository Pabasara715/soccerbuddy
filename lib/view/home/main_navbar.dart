import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccerbuddy/view/home/Pages/blank_page.dart';
import 'package:soccerbuddy/view/home/Pages/blnk_2_page.dart';
import 'package:soccerbuddy/view/home/Pages/home_view.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();

  List<Widget> myWigets = <Widget>[
    const HomeView(),
    BlankPage(),
    Blank_2_page(),
  ];

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: pageBucket, child: currentTab),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.grey.shade700,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _page = index;
              currentTab = myWigets[index];
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(Icons.fitness_center, color: Colors.white),
            Icon(Icons.live_tv, color: Colors.white),
          ]),
      appBar: AppBar(actions: [
        IconButton(onPressed: _signOut, icon: const Icon(Icons.logout))
      ]),
    );
  }
}