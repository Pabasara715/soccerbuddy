import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:soccerbuddy/models/skill.dart';
import 'package:soccerbuddy/view/home/Pages/Skills/skill_step_detials.dart';

class SkillTile extends StatelessWidget {
  final Skill skill;

  SkillTile({Key? key, required this.skill}) : super(key: key);

  final storageRef = FirebaseStorage.instance.ref();

  Future<String> getImageUrl(String username) async {
    try {
      final imageRef = storageRef.child('images/${username}.jpg');
      final String downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SkillStepDetail(skill: skill),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 244, 67, 54).withOpacity(0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FutureBuilder<String>(
          future: getImageUrl(skill.skillName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 7,
                          blurRadius: 8,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        snapshot.data!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    skill.skillName.toUpperCase(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto"),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error loading image');
            } else {
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(200, 7, 251, 133),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
