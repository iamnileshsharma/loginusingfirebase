import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
  class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);
  
    @override
    _HomePageState createState() => _HomePageState();
  }
  
  class _HomePageState extends State<HomePage> {
    final _auth= FirebaseAuth.instance;
    @override
    Widget build(BuildContext context) {
      return Container(
        child: ElevatedButton(
          child: const Text("log out"),
          onPressed: (){
            _auth.signOut().then((_){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
            });
          },
        ),
      );
    }
  }
  