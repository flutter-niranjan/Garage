import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:garage/firebasedataupload.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class LoginData extends ChangeNotifier {
  String loginType = 'user';
  String verificationId = '';
  String completeNumber = '+9452165142135';
  String name = '';
  String email = '';
  String dOB = '';
  String gender = '';
  String mobile = " ";

  void setLoginType(String newType) {
    loginType = newType;
    notifyListeners();
  }

  void setNumber(String newNumber) {
    completeNumber = newNumber;
    notifyListeners();
  }

  void setVerificationId(String newID) {
    verificationId = newID;
    notifyListeners();
  }

  void setData(
      {String? newName, String? newEmail,String? newMobile, String? newDOB, String? newGender}) {
    name = newName ?? name;
    email = newEmail ?? email;
    mobile = newMobile ?? mobile;
    dOB = newDOB ?? dOB;
    gender = newGender ?? gender;
    notifyListeners();
  }
}

class CarInfo extends ChangeNotifier {
  String carCompany = '';
  String carFuelType = '';
  String carModel = '';

  void setCarCompany(String newCarCompany) {
    carCompany = newCarCompany;
    ChangeNotifier();
  }

  void setCarModel(String newCarModel) {
    carModel = newCarModel;
    ChangeNotifier();
  }

  void setCarFuel(String newCarFuel) {
    carFuelType = newCarFuel;
    ChangeNotifier();
  }
}

class Loader extends ChangeNotifier {
  bool isGetOtpLoaderOn = false;
  Widget getOtpLoader = Text(
    "GET OTP",
    style: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
  );
  void changeGetOtpLoader(String value) {
    if (value == 'on') {
      getOtpLoader = SizedBox(
          height: 30, width: 30, child: Image.asset('assets/loading.gif'));
      isGetOtpLoaderOn = true;
      log('loader on');
      ChangeNotifier();
    } else {
      getOtpLoader = Text(
        "GET OTP",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      );
      isGetOtpLoaderOn = false;
    }
    ChangeNotifier();
  }

  bool submitOtpLoader = false;
  void changeSubmitOtpLoader(value) {
    isGetOtpLoaderOn = value;
    ChangeNotifier();
  }
}
