import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:soccerbuddy/common_widget/round_button.dart';
import 'package:soccerbuddy/common_widget/step_detail_row.dart';
import 'package:soccerbuddy/models/skill.dart';

class SkillStepDetail extends StatefulWidget {
  final Skill skill;

  const SkillStepDetail({Key? key, required this.skill}) : super(key: key);

  @override
  State<SkillStepDetail> createState() => _SkillStepDetailState();
}

class _SkillStepDetailState extends State<SkillStepDetail> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> getImageUrl(String username) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('SkillThumbs/$username.jpg');
      final String downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

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
              FutureBuilder<String>(
                future: getImageUrl(skillname),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError || snapshot.data == null) {
                      return Text('Error loading image');
                    }

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: media.width,
                                height: media.width * 0.43,
                                child: Image.network(
                                  snapshot.data!,
                                  width: media.width,
                                  height: media.width * 0.43,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: media.width,
                              height: media.width * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
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
                      'detail': step,
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
                },
              ),
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
