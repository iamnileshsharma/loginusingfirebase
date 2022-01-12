import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verification.dart';
import 'homepage.dart';
import 'reset.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "email",
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "password",
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Signin(_email, _password);
                  },
                  child: Text("login"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    primary: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Signup(_email, _password);
                  },
                  child: Text("Signup"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    primary: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reset(),
                            ),
                          );
                        },
                        child: Text("forgot password??"))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Signup(_email, _password) async {
    await _auth
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((_) {
      try {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => verification()));
      } on FirebaseAuthException catch (error) {
        Fluttertoast.showToast(msg: "error", gravity: ToastGravity.TOP);
      }
    });
  }

  Signin(_email, _password) async {
    await _auth
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((_) {
      try {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("message")));
      }
    });
  }
}
