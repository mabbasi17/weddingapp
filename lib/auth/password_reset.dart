// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weddingapp/theme.dart';

class PasswordReset extends StatefulWidget {
  PasswordReset({Key? key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('images/icon.png'),
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: width * 0.95,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(46))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 45, left: 25, right: 25),
                            child: Text('Password Reset'.tr,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            child: Column(children: [
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                                'Contact System Admin for Password Reset'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(height: 40),
                        ]))
                      ]),
                )),
          )
        ],
      ),
    );
  }
}
