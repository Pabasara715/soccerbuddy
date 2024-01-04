import 'package:flutter/material.dart';
import 'package:soccerbuddy/models/skill.dart';

class SkillTile extends StatelessWidget {
  final Skill skill;
  SkillTile({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      width: 300,
      height: 200, // Set the height of the Container
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      // Adjusts the image to cover the available space
      child: Image.asset(skill.photoUrl),
    );
  }
}
