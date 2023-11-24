// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:soccerbuddy/common/colo_extension.dart';
import 'package:soccerbuddy/common_widget/on_boarding_page.dart';
import 'package:soccerbuddy/view/login/auth_page.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  int selectPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;
      setState(() {});
    });
  }

  PageController controller = PageController();

  List pageList = [
    {
      "title": "Let's Begin the Journey",
      "subtitle":
          "Join our soccer app for the ultimate soccer experience. Improve your skills with expert training exercises, track your schedule and match details, and connect with like-minded users. Discover personalized training, enhance match performance, and stay motivated on your soccer journey. Connect with fellow players, share experiences, and arrange games easily. It's your all-in-one soccer companion for success and community in one place",
      "image": "assets/img/Vector.png"
    },
    {
      "title": "Master Your Skills",
      "subtitle":
          "Unlock the potential within you with our app's expert training exercises and resources. Elevate your soccer skills to the next level and become a true master of the game, all while meeting new friends who share your passion for soccer.",
      "image": "assets/img/vector2.png"
    },
    {
      "title": "Stay Connected",
      "subtitle":
          "Connect and engage with a vibrant soccer community. Stay updated with the latest news, share tips, and build lasting connections with fellow enthusiasts. Our app is your gateway to a world where soccer brings us together.",
      "image": "assets/img/vector3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: pageList.length,
              itemBuilder: (context, index) {
                var pObj = pageList[index] as Map? ?? {};
                return OnBoardingPage(pObj: pObj);
              }),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColo.primaryColor1,
                    value: (selectPage + 1) / pageList.length,
                    strokeWidth: 2,
                  ),
                ),
                Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                        color: TColo.primaryColor3,
                        borderRadius: BorderRadius.circular(35)),
                    child: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (selectPage < pageList.length - 1) {
                          selectPage = selectPage + 1;
                          controller.jumpToPage(selectPage);
                          setState(() {});
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthPage()));
                        }
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
