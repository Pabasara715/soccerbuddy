import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soccerbuddy/common/common.dart';
import '../../../../common_widget/round_button.dart';
import 'package:uuid/uuid.dart';
import './workout_schedule_view.dart';

class AddScheduleView extends StatefulWidget {
  final DateTime date;
  const AddScheduleView({super.key, required this.date});

  @override
  State<AddScheduleView> createState() => _AddScheduleViewState();
}

class _AddScheduleViewState extends State<AddScheduleView> {
  _AddScheduleViewState() {
    selectedValue = workoutList[0];
  }
  final workoutList = [
    'Passing',
    "Dribbling",
    "Heading",
    'Shooting',
    "Tackling"
  ];
  String selectedValue = "Skill1";
  String eventId = "";

  final user = FirebaseAuth.instance.currentUser!;

  void addEventDataToUser(
      String username, Map<String, dynamic> newEvent) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('Username', isEqualTo: username).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocumentRef = querySnapshot.docs.first.reference;

        await userDocumentRef.update({
          'events': FieldValue.arrayUnion([newEvent])
        });

        print('Data added to user with username: $username');
      } else {
        print(
            'User with username $username not found. Consider creating the user first.');
      }
    } catch (e) {
      print('Error adding data to user: $e');
    }
  }

  TextEditingController timeController = TextEditingController();
  String selectedType = "Skill1";
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    updateTime(DateTime.now());
  }

  DateTime newtime = DateTime.now();
  void updateDate(DateTime newDate) {
    newtime = newDate;
  }

  void updateTime(DateTime dateTime) {
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    String formattedDateTime = DateFormat('dd/MM/yyyy').format(widget.date);
    timeController.text = '$formattedDateTime $formattedTime';
    selectedDateTime = dateTime;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
            child: Image.asset(
              "assets/img/back_btn.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Add Skill to the Schedule",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            width: 8,
          ),
          Center(
            child: Text(
              dateToString(widget.date, formatStr: "E, dd MMMM yyyy"),
              style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Time",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: media.width * 0.35,
            child: CupertinoDatePicker(
              onDateTimeChanged: (newDate) {
                updateDate(newDate);
              },
              initialDateTime: DateTime.now(),
              use24hFormat: false,
              minuteInterval: 1,
              mode: CupertinoDatePickerMode.time,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Details Workout",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          DropdownButtonFormField(
            value: selectedValue,
            items: workoutList
                .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedValue = val as String;
              });
            },
            icon: const Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.pinkAccent,
            ),
            decoration: InputDecoration(
                labelText: "Choose the Skill",
                prefixIcon: Icon(Icons.sports_gymnastics)),
          ),
          const SizedBox(
            height: 10,
          ),
          Spacer(),
          RoundButton(
              title: "ADD WORKOUT",
              onPressed: () async {
                updateTime(newtime);
                eventId = Uuid().v4();
                addEventDataToUser(user.email!, {
                  "id": eventId,
                  "name": selectedValue,
                  "start_time": timeController.text,
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    'Work Out Added Successfully',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ));
              }),
          const SizedBox(
            height: 300,
          ),
        ]),
      ),
    );
  }
}
