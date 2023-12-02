import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final user = FirebaseAuth.instance.currentUser!;
  String displayName = "user";

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    if (user.displayName == null) {
      displayName = user.email.toString();
    } else {
      setState(() {
        displayName = user.displayName.toString();
      });
    }

    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        user.photoURL != null && user.photoURL!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  user.photoURL!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 20,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                displayName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _signOut,
                      icon: Image.asset(
                        "assets/img/logout.png",
                        width: 25,
                        height: 25,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Container(
                  height: media.width * 0.42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.grey,
                        Colors.black,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(media.width * 0.075),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/img/abstract.png",
                        height: media.width * 0.4,
                        width: double.maxFinite,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Today Your Progress',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  "Let's get back on business",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: media.width * 0.01,
                                ),
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(153, 255, 105, 105),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {},
                                    splashColor: Colors.white.withOpacity(0.5),
                                    child: SizedBox(
                                      width: media.width * 0.3,
                                      height: media.width * 0.1,
                                      child: const Center(
                                        child: Text(
                                          'View Tasks',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              child: CircularPercentIndicator(
                                animation: true,
                                radius: 60,
                                lineWidth: 10,
                                percent: 0.4,
                                progressColor: Colors.blueAccent,
                                backgroundColor: Colors.white,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: const Text(
                                  '40%',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
