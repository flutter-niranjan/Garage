import 'package:flutter/material.dart';
import 'package:garage/Model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(name: "", mobile: "");

  UserModel get user => _user;

  void updateUser(String name, String mobile) {
    _user = UserModel(name: name, mobile: mobile);
    notifyListeners();
  }
}
