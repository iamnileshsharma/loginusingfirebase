import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class verification extends StatefulWidget {
  const verification({Key? key}) : super(key: key);

  @override
  _verificationState createState() => _verificationState();
}

class _verificationState extends State<verification> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer time;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    time = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Verification email has been sent to ${user.email} please click link to verify"),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      time.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }
}
