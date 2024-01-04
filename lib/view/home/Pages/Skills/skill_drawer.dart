import 'package:flutter/material.dart';
import 'package:soccerbuddy/components/skill_tile.dart';
import 'package:soccerbuddy/models/skill.dart';

class SkillDrawer extends StatelessWidget {
  const SkillDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(''),
          automaticallyImplyLeading: false // Replace with your desired title
          ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text(
            'SKILL GALLERY',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Making the text bold
              fontSize: 24, // Adjusting the font size
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Skill skill = Skill(
                  skillID: 'skillID',
                  skillName: 'skillName',
                  skillDescription: 'skillDescription',
                  photoUrl: 'assets/img/Vector.png',
                  skillSteps: ['sll', 'ssdads'],
                );
                return SkillTile(skill: skill);
              },
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
