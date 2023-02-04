import 'dart:io';
import 'package:get/get.dart';
import 'nointernet.dart';

Future<Function> checkInternetConnection(stat) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      Get.back();
      stat = 1;
    }
  } on SocketException catch (_) {
    Get.to(NoInternet());
    stat = 0;
  }
  return stat;
}
