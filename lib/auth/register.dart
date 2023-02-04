// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'dart:convert';
import './login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var password = '';
  var repassword = '';
  var name = '';
  var email = '';

  Future RegisterCustomer() async {
    var url = Uri.parse("http://aldar.syrianstores.com/api/createuser");
    http.Response response = await http.post(url, body: {
      "name": name.toString(),
      "email": email.toString(),
      "password": password.toString(),
    });

    List responseBody = jsonDecode(response.body);

    if (responseBody[0]['result'] == '1') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      Get.snackbar("Login".tr, "Successfully Registered!".tr,
          snackPosition: SnackPosition.TOP);
    } else {
      var msg = responseBody[0]['msg'];
      Get.snackbar("Login".tr, msg, snackPosition: SnackPosition.TOP);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 20),
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
//validate
            if (name.length < 2) {
              Get.snackbar("Login".tr, "Short Username!".tr,
                  snackPosition: SnackPosition.TOP);
            } else if (email.length < 9) {
              Get.snackbar("Login".tr, "wrong Email!".tr,
                  snackPosition: SnackPosition.TOP);
            } else if (password.length < 8) {
              Get.snackbar("Login".tr,
                  "Pasword must be at least 8 letters or numbers!".tr,
                  snackPosition: SnackPosition.TOP);
            } else if (password != repassword) {
              Get.snackbar("Login".tr, "Paswords dont match!".tr,
                  snackPosition: SnackPosition.TOP);
            } else {
              //send to back end
              RegisterCustomer();
            }
          },
          elevation: 5,
          child: const Icon(Icons.arrow_forward_ios_sharp),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                width: width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                  // bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 25, right: 25),
                            child: Text('New Account'.tr,
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            child: Column(children: [
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide()),
                                  hintText: 'User'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide()),
                                  hintText: 'Email'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.password_outlined),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide()),
                                  hintText: 'Password'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.password_sharp),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide()),
                                  hintText: 'Re-Type Password'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                              onChanged: (value) {
                                setState(() {
                                  repassword = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: Text(
                                    style:
                                        const TextStyle(color: kPrimaryColor),
                                    'Sing in instead'.tr,
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      Login(),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ]))
                      ]),
                )),
          )
        ],
      ),
    );
  }
}
