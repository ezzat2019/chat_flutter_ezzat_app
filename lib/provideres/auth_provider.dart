import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  bool _is_login = false;
  bool _is_progress_show = false;
  String _image = null;
  File finalImage = null;

  void setImage(String value) {
    _image = value;
    finalImage = File(_image);
    notifyListeners();
  }

  final picker = ImagePicker();

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
