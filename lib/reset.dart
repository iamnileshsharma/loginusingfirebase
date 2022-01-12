import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';



class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _email;

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    try{
                      _auth.sendPasswordResetEmail(email: _email);
                      Navigator.pop(context);

                    } on FirebaseAuthException catch(e){
                      print("cant send email");
                      print(e.code);
                    };
                  },
                  child: Text("Reset"),
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
                              builder: (context) => Login(),
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
}
