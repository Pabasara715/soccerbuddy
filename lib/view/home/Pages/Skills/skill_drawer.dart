import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          isLoading = false; // Set loading state to false when data is loaded
        });
      } else {
        print('No documents found in the collection.');
        setState(() {
          isLoading =
              false; // Set loading state to false when no documents found
        });
      }
    } catch (e) {
      print('Error loading skills from Firestore: $e');
      setState(() {
        isLoading = false; // Set loading state to false on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/back_btn.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Text(
          'SKILL GALLERY',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: skills.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Skill skill = skills[index];
                      return SkillTile(skill: skill);
                    },
                  ),
                ),
                SizedBox(height: 70),
                const SizedBox(height: 50),
              ],
            ),
    );
  }
}
