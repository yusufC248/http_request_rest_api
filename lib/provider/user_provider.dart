import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? newUser) {
    _user = newUser;
    notifyListeners();
  }
}
