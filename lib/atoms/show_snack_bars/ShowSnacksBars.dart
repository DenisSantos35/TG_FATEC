import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBars {
  static ErrorPrice({required String title, required String message}) {
    return Get.showSnackbar( GetSnackBar(
      title: title,
      message: message,
      backgroundColor: Color(0xffee0808),
      duration: Duration(seconds: 3),
    ));
  }
}
