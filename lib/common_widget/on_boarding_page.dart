// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  final Map pObj;
  const OnBoardingPage({super.key, required this.pObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      height: media.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(pObj["image"].toString(),
                width: media.width, fit: BoxFit.fitWidth),
            SizedBox(height: media.width * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                pObj["title"].toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: media.width * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                pObj["subtitle"].toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            )
          ]),
    );
  }
}
