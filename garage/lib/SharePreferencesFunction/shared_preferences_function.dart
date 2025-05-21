

import 'package:flutter/material.dart';
import 'package:garage/Providers/login_data.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void setLoginPreferences(BuildContext context)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('LoginData_completeNumber', context.read<LoginData>().completeNumber);
  pref.setString('LoginData_loginType', context.read<LoginData>().loginType);
}

Future isAccountLogined() async{
SharedPreferences pref=await SharedPreferences.getInstance();
if(pref.getString('LoginData_completeNumber')==null){
  return false;
}
  return true;
}