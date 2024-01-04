import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soccerbuddy/models/users.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  creatUser(users user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, StackTrace stackTrace) {
      print('Caught error: $error');
      print('Stack trace: ${stackTrace.toString()}');
    });
  }
}
