import 'package:flutter/material.dart';
import 'package:soccerbuddy/models/skill.dart';
import 'package:soccerbuddy/view/home/Pages/Skills/skill_step_detials.dart';

class SkillTile extends StatelessWidget {
  final Skill skill;

  SkillTile({Key? key, required this.skill}) : super(key: key);

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
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 58, 58, 58),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              skill.photoUrl,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              skill.skillName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
