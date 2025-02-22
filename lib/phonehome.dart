import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';

import 'otppage.dart';

class PhoneHome extends StatefulWidget {
  const PhoneHome({super.key});

  @override
  State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
  TextEditingController phonenumber=TextEditingController();
  
  sendcode()async{
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91'+phonenumber.text,
          verificationCompleted: (PhoneAuthCredential credential){},
          verificationFailed: (FirebaseAuthException e){
          Get.snackbar('Error Occured',e.code);
          }, codeSent: (String vid,int? token){
          Get.to(OtpPage(vid: vid,),);
      }, codeAutoRetrievalTimeout: (vid){});

    }
    on FirebaseAuthException catch(e){
      Get.snackbar('Error Occured',e.code);
    }catch(e){
      Get.snackbar('Error Occured', e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(child:  Text("Your Phone"),),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
          child: Text("we will send you an OTP"),),
          SizedBox(height: 20,),
          phonetext(),
          SizedBox(height: 50,),
          button(),
        ],
      ),
    );
  }

  Widget phonetext() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 50),
    child: TextField(
      controller: phonenumber,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefix: Text("+91 "),
        prefixIcon: Icon(Icons.phone),
        labelText: 'Enter Phone Number',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:  Colors.black),
        ),
      ),
    ),);
  }

 Widget button() {
    return Center(
      child: ElevatedButton(onPressed: (){
        sendcode();
      },style:  ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(90, 208, 248,1.0),
        padding: const EdgeInsets.all(16.0),
      ), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 90),
      child: Text('OTP',style: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),),)),
    );
 }
}
