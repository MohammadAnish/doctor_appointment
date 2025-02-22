import 'package:doctor_appointment/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String vid;
  const OtpPage({super.key, required this.vid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  var code = ' ';

  get value => null;

  signIn() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.vid,
        smsCode: code);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then(
          (value));
      Get.offAll(Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occured', e.code);
    }
    catch (e) {
      Get.snackbar('Error Occured', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(child: Text("OTP Verification", style: TextStyle(
              fontSize: 30,
            ),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: Text("Enter OTP "),),
            SizedBox(height: 20,),
            textcode(),
            SizedBox(height: 80,),
            button()
          ],
        ),

      ),
    );
  }

  Widget textcode() {
    return Center(
      child: Padding(padding: const EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
        ),),
    );
  }


  Widget button() {
    return Center(
      child: ElevatedButton(onPressed: () {
        signIn();
      }, style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(140, 178, 241, 1),
      ), child: Text('Verify & Proceed',
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),)),
    );
  }

}


