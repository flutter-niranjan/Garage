import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage/Providers/login_data.dart';
import 'package:garage/Screens/LoginScreen/login.dart';
import 'package:garage/Screens/Profile/myprofile.dart';
import 'package:garage/Screens/Profile/myprofilefirsttime.dart';
import 'package:garage/Screens/Profile/profilescreen.dart';
import 'package:garage/firebasedataupload.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State createState() => _OtpscreenState();
}
 
class _OtpscreenState extends State {
  TextEditingController number1=TextEditingController();
  TextEditingController number2=TextEditingController();
  TextEditingController number3=TextEditingController();
  TextEditingController number4=TextEditingController();
  TextEditingController number5=TextEditingController();
  TextEditingController number6=TextEditingController();

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20),
            child: Text(
              "We have sent a 6 digit OTP on",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 140, left: 20),
                child: Text(context.watch<LoginData>().completeNumber,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140, left: 20),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text(
                    "EDIT",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190, left: 20),
            child: Text(
              "Enter the OTP below to verify your number",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 55,
                padding: const EdgeInsets.only(top: 250),
                child: TextField(
                  controller: number1,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headlineMedium,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: 55,
                padding: const EdgeInsets.only(top: 250),
                child: TextField(
                  controller: number2,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headlineMedium,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: 55,
                padding: const EdgeInsets.only(top: 250),
                child: TextField(
                  controller: number3,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headlineMedium,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: 55,
                padding: const EdgeInsets.only(top: 250),
                child: TextField(
                  controller: number4,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headlineMedium,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: 55,
                padding: const EdgeInsets.only(top: 250,),
                child: TextField(
                  controller: number5,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headlineMedium,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: 55,
                padding: const EdgeInsets.only(top: 250,),
                child: TextField(
                  controller: number6,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context).textTheme.headlineMedium,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 340, left: 120),
                child: Text(
                  "Resend OTP in ",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 340),
                child: TimerCountdown(
                  enableDescriptions: false,
                  timeTextStyle: const TextStyle(
                    fontFamily: "poppins",
                    fontSize: 15,
                  ),
                  format: CountDownTimerFormat.secondsOnly,
                  endTime: DateTime.now().add(
                    const Duration(
                      seconds: 60,
                    ),
                  ),
                  onEnd: () => print("Resend OTP"),
                ),
              )
            ],
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 400, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: (){
                if(number1.text.isNotEmpty && number2.text.isNotEmpty && number3.text.isNotEmpty && number4.text.isNotEmpty && number5.text.isNotEmpty && number6.text.isNotEmpty ){
                  String otp=number1.text+number2.text+number3.text+number4.text+number5.text+number6.text;
                  log(otp);
                  sumbitOTP(context,otp);
                  // Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return const MyprofileFirstTime();
                  //     }));
                }
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:context.read<Loader>().submitOtpLoader ? SizedBox(
                height: 30,
                width: 30,
                child: Image.asset('assets/loading.gif')): Text(
                "CONTINUE",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 795),
            height: 50,
            width: double.infinity,
            color: const Color.fromARGB(255, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Auto Fill OTP",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text(
                    "EDIT NUMBER",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
