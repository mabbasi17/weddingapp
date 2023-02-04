import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import '../generalfunctions.dart';
import 'package:get/get.dart';
import '../theme.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
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
          backgroundColor: kPrimaryLightColor,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(child: Text('Check Your Connection'.tr)),
                const SizedBox(height: 10),
                Center(
                    child: Image.asset('images/nointernet.jpg', width: width)),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    child: Text('Retry'.tr),
                    onPressed: () {
                      checkInternetConnection(0);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
