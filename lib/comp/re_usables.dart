import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

class ReusableWidgets {
  static getAppBar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      backgroundColor: kPrimaryColor,
    );
  }
}
