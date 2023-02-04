import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../theme.dart';

class ActivateAccount extends StatefulWidget {
  ActivateAccount({Key? key}) : super(key: key);

  @override
  _ActivateAccountState createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  var email = null;
  Future checkactivation() async {
    var prefs = await SharedPreferences.getInstance();
    var loggedemail = prefs.getString('user_email');
    setState(() {
      email = loggedemail;
    });
    if (email != null) {
      var url =
          Uri.parse("http://aldar.syrianstores.com/api/getcustomeractivation");
      http.Response response = await http.post(url, body: {
        "email": email,
      });

      List responseBody = jsonDecode(response.body);

      if (responseBody[0]['data'][0] == '0') {
        Get.snackbar(
            "Login".tr, "Please wait until Your Account is Activated!".tr,
            snackPosition: SnackPosition.TOP);
      } else if (responseBody[0]['data'][0] == '1') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    checkactivation();
    super.initState();
  }

  @override
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
                  content: Text('Are you sure you want to exit?'.tr),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text('No'.tr),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Yes'.tr),
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
            backgroundColor: Colors.grey.shade300,
            resizeToAvoidBottomInset: false,
            body: (email == null)
                ? Center(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child:
                                Text('Please Login or Register New Account'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login', (Route<dynamic> route) => false);
                            },
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            child: Text('Login'.tr),
                            padding: const EdgeInsets.all(16),
                            // shape: CircleBorder(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/register',
                                    (Route<dynamic> route) => false);
                              },
                              color: kPrimaryColor,
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(16),
                              child: Text('Register'.tr),
                              // shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                //Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: checkactivation,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0, bottom: 60),
                        child: Center(
                            child: Column(
                          children: [
                            const Icon(
                              Icons.vpn_key,
                              size: 200,
                              color: kPrimaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Column(
                                children: [
                                  Text(
                                      'Please Contact Admin to  Activate your Account or check Internet Connection and Refresh by Scrolling Down'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('$email',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  )));
  }
}
