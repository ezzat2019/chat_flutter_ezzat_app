import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _is_login=false;
  bool _is_progress_show=false;

  bool get is_progress_show => _is_progress_show;

  void set_is_progress_show(bool value) {
    _is_progress_show = value;
    notifyListeners();
  }

  bool get is_login => _is_login;

  void set_is_login(bool value) {
    _is_login = value;
    notifyListeners();
  }
}