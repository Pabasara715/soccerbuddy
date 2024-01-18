import 'package:soccerbuddy/models/users.dart';

class Skill {
  String skillID = "";
  String skillName = "";
  String skillDescription = "";
  String photoUrl = "";
  List<String> skillSteps = [];

  List<users> watchingUsers = [];

  Skill(
      {required this.skillID,
      required this.skillName,
      required this.skillDescription,
      required this.photoUrl,
      required this.skillSteps});
}
