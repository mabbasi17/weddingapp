// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'password_reset.dart';
import 'register.dart';
import '../homepage.dart';
import 'dart:convert';
import '../theme.dart';
import '../generalfunctions.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = '',
      password = '',
      logged_token,
      user_id,
      user_name,
      user_email,
      user_password;

  Future checklogin() async {
    checkInternetConnection(0);

    var url = Uri.parse("http://aldar.syrianstores.com/api/customerlogin");
    http.Response response = await http.post(url, body: {
      "email": email.toString(),
      "password": password.toString(),
    });

    List responseBody = jsonDecode(response.body);
    // print(responseBody);
    if (responseBody[0]['result']! == '0') {
      var msg = responseBody[0]['msg'];
      Get.snackbar("Login".tr, msg, snackPosition: SnackPosition.TOP);
    } else {
      setLogin(responseBody[0]['data']);
      Get.to(MyHomePage());
    }
  }

  setLogin(data) async {
    var prefs = await SharedPreferences.getInstance();
    user_id = (data['id']).toString();
    prefs.setString('user_id', user_id ?? '0');
    prefs.setString('user_name', data['name'] ?? 'user');
    prefs.setString('user_email', data['email'] ?? 'user@gmail.com');
    prefs.setString('token', data['token'] ?? null);
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  titleTextStyle: const TextStyle(
                      color: kPrimaryColor,
                      backgroundColor: kPrimaryLightColor),
                  content: Text('Are you sure you want to exit?'.tr,
                      style: const TextStyle(color: kPrimaryColor)),
                  actions: <Widget>[
                    IconsOutlineButton(
                      color: kPrimaryColor,
                      textStyle: const TextStyle(color: kPrimaryLightColor),
                      text: 'No'.tr,
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    IconsOutlineButton(
                      textStyle: const TextStyle(color: kPrimaryLightColor),
                      text: 'Yes'.tr,
                      color: kPrimaryColor,
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                );
              });

          return value == true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 20),
              child: FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  if (email.length < 9) {
                    Get.snackbar("Login".tr, 'wrong Email!'.tr,
                        snackPosition: SnackPosition.TOP);
                  } else if (password.length < 8) {
                    Get.snackbar("Login".tr,
                        "Pasword must be at least 8 letters or numbers!".tr,
                        snackPosition: SnackPosition.TOP);
                  } else {
                    checklogin();
                  }
                },
                elevation: 5,
                child: const Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: Center(),
                        ),
                      )),
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
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 45, left: 25, right: 25),
                                    child: Text('Welcome Back'.tr,
                                        style: const TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                    child: Column(children: [
                                  const SizedBox(height: 50),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.email),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide()),
                                          hintText: 'Email'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14)),
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });

                                        // name = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                              Icons.password_outlined),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                          hintText: 'Password'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14)),
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Get.to(PasswordReset());
                                            },
                                            child: Text(
                                              style: const TextStyle(
                                                  color: kPrimaryColor),
                                              'Forgot Password'.tr,
                                            )),
                                        TextButton(
                                          child: Text(
                                            style: const TextStyle(
                                                color: kPrimaryColor),
                                            'Sing Up'.tr,
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              const SignUp(),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ])),
                              ]),
                        )),
                  )
                ],
              ),
            )));
  }
}

class MyWidIn extends StatelessWidget {
  const MyWidIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
    );
  }
}
