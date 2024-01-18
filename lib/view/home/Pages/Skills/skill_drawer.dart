import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccerbuddy/components/skill_tile.dart';
import 'package:soccerbuddy/models/skill.dart';

class SkillDrawer extends StatefulWidget {
  const SkillDrawer({Key? key}) : super(key: key);

  @override
  _SkillDrawerState createState() => _SkillDrawerState();
}

class _SkillDrawerState extends State<SkillDrawer> {
  List<Skill> skills = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSkillsFromFirestore();
  }

  Future<void> loadSkillsFromFirestore() async {
    CollectionReference skillsCollection =
        FirebaseFirestore.instance.collection('Skills');

    try {
      QuerySnapshot querySnapshot = await skillsCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          skills = querySnapshot.docs.map((document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return Skill(
              skillID: document.id,
              skillName: data['skillName'] ?? '',
              skillDescription: data['skillDescription'] ?? '',
              photoUrl: data['photoUrl'] ?? '',
              skillSteps: List<String>.from(data['skillSteps'] ?? []),
            );
          }).toList();
          isLoading = false;
        });
      } else {
        print('No documents found in the collection.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading skills from Firestore: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  final user = FirebaseAuth.instance.currentUser!;
  double progress = 0.5;
  String displayName = "user";

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await GoogleSignIn().disconnect();

    FirebaseAuth.instance;

    print(user);
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

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 132, 133, 132), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            Container(
              color: Color.fromARGB(255, 0, 0, 0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        user.photoURL != null && user.photoURL!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  user.photoURL!,
                                  width: 30,
                                  height: 30,
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
                              const Text(
                                "Welcome Back !",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                displayName,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
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
                      icon: Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "SKILL GALLERY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: skills.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Skill skill = skills[index];
                        return SkillTile(skill: skill);
                      },
                    ),
                  ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
