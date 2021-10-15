import 'package:flutter/material.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;

  set user(User? newUser) {
    _user = newUser;
    notifyListeners();
  }

  logout(String? token){
    token = null;
    _token = token;
    _user = null;
    notifyListeners();
  }
}
