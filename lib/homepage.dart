import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/phonehome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user=FirebaseAuth.instance.currentUser;

  signout()async{
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${user!.phoneNumber}"),),
      floatingActionButton: FloatingActionButton(onPressed: (()=>signout()),
        child: Icon(Icons.login_rounded),),

    );
  }
}
