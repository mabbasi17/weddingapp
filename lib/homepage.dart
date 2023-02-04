import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //import 'comp/re_usables.dart';
import 'package:get/get.dart';
import 'comp/main_drawer.dart';
import 'comp/re_usables.dart';
import 'theme.dart';
import 'langs/translations.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
            appBar: ReusableWidgets.getAppBar('Home'.tr),
            drawer: MainDrawer(),
            body: Center(
              child: Center(
                child: Column(
                  children: [
                    Text('Home'.tr,
                        style: const TextStyle(
                            //   color: AppPrimaryColor,

                            fontSize: 40))
                  ],
                ),
              ),
            )));
  }
}
