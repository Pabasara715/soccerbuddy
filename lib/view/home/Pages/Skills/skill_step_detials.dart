import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:readmore/readmore.dart';
import 'package:soccerbuddy/models/skill.dart';
import '../../../../common_widget/round_button.dart';
import '../../../../common_widget/step_detail_row.dart';

class SkillStepDetail extends StatefulWidget {
  final Skill skill;
  const SkillStepDetail({super.key, required this.skill});

  @override
  State<SkillStepDetail> createState() => _SkillStepDetailState();
}

class _SkillStepDetailState extends State<SkillStepDetail> {
  late Map eObj;

  @override
  Widget build(BuildContext context) {
    var skillname = widget.skill.skillName;
    var media = MediaQuery.of(context).size;
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
        title: Text(
          skillname,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: media.width,
                    height: media.width * 0.43,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 74, 235, 79),
                          Color.fromARGB(255, 136, 250, 43)
                        ]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.asset(
                      "assets/img/video_temp.png",
                      width: media.width,
                      height: media.width * 0.43,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: media.width,
                    height: media.width * 0.43,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Descriptions",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              ReadMoreText(
                widget.skill.skillDescription,
                trimLines: 4,
                colorClickableText: Colors.black,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Read More ...',
                trimExpandedText: ' Read Less',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                moreStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "How To Do It",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.skill.skillSteps.length,
                itemBuilder: ((context, index) {
                  var step = widget.skill.skillSteps[index];

                  return StepDetailRow(
                    sObj: {
                      'no': index + 1,
                      'title': 'Step ${index + 1}',
                      'detail': step
                    },
                    isLast: index == widget.skill.skillSteps.length - 1,
                  );
                }),
              ),
              const SizedBox(
                height: 15,
              ),
              RoundButton(
                  title: "OK",
                  elevation: 0,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
