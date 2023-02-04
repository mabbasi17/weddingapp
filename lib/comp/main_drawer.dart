// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var user_id, user_name, user_email, user_avatar, allowance, balance;
  getUserinfo() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      user_avatar = prefs.getString('user_avatar');
      user_id = prefs.getString('user_id');
      user_name = prefs.getString('user_name');
      user_email = prefs.getString('user_email');
      allowance = prefs.getString('allowance');
    });
  }

  @override
  void initState() {
    // getUserinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryLightColor,
      child: Container(
        child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
          Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('$user_name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('$user_email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      )),
                ],
              )),
          ListTile(
            title: Text('Shop Now'.tr, style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.toys_sharp,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/selectfilter');
            },
          ),
          Divider(),
          ListTile(
            title: Text('My Cart'.tr, style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.shopping_cart,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/mycart');
            },
          ),
          ListTile(
            title:
                Text('Track Orders'.tr, style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.pageview,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/track');
            },
          ),
          ListTile(
            title: Text('Deliverd Orders'.tr,
                style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.inventory_outlined,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/deliveredorders');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Finicial Report'.tr,
                style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.credit_card,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/accreport');
            },
          ),
          Divider(),
          ListTile(
            title:
                Text('Contact Us'.tr, style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.call,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/contactus');
            },
          ),
          ListTile(
            title: Text('Language'.tr, style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.language,
              size: 30,
            ),
            onTap: () {
              var localnow = Get.locale;
              if (localnow.toString() == 'en') {
                var localear = Locale('ar', '');
                Get.updateLocale(localear);
              } else {
                var localeen = Locale('en', '');
                Get.updateLocale(localeen);
              }
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text('Sing Out'.tr, style: TextStyle(color: kPrimaryColor)),
            leading: Icon(
              color: kPrimaryColor,
              Icons.close,
              size: 30,
            ),
            onTap: () async {
              Dialogs.materialDialog(
                  msg: 'Do You Really Wanna Sign out?'.tr,
                  title: "Sign out".tr,
                  color: kPrimaryLightColor,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'No'.tr,
                      // iconData: Icons.cancel_outlined,
                      textStyle: TextStyle(color: kPrimaryColor),
                      iconColor: kPrimaryColor,
                    ),
                    IconsButton(
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Get.snackbar(
                            "Sign out".tr, "Signed out successfully!".tr);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                      text: "Yes".tr,
                      // iconData: Icons.delete,

                      textStyle: TextStyle(color: kPrimaryColor),
                      iconColor: kPrimaryColor,
                    ),
                  ]);
            },
          ),
        ]),
      ),
    );
  }
}
