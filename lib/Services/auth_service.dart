import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccerbuddy/models/users.dart';
import 'package:soccerbuddy/repository/user_repository.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('Username', isEqualTo: user?.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      print("yes");
    } else {
      if (user != null) {
        final userRepo = Get.put(UserRepository());
        final user_g = users(
          username: user.email!,
          password: "google.user",
        );

        userRepo.creatUser(user_g);
      }
    }
  }
}
