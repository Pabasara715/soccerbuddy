import 'package:flutter/material.dart';
import 'package:soccerbuddy/view/home/Pages/Skills/skill_drawer.dart';
import 'package:soccerbuddy/view/home/Pages/Skills/skill_step_detials.dart';
import 'package:soccerbuddy/view/home/Pages/WorkOutSchedule/workout_schedule_view.dart';

class SheduleSkillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shedule Skill Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SkillDrawer()),
                );
              },
              child: Text('View Skill Details'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutScheduleView()),
                );
              },
              child: Text('Go to Schedule Page'),
            ),
          ],
        ),
      ),
    );
  }
}
