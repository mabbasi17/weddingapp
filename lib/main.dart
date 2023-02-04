import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'langs/translations.dart';
import 'package:flutter/services.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'theme.dart';
import 'homepage.dart';
import 'wizzard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool islogged = false;
    bool iswizzard = true;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppTitle'.tr,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ))),
      home: const MyHomePage(),

      initialRoute:
          (iswizzard ? '/Wizzard' : (islogged ? '/home' : '/register')),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => const SignUp(),
        '/home': (context) => const MyHomePage(),
        '/Wizzard': (context) => const OnBoardingPage(),
      },
      translations: Translation(),
      locale: const Locale('ar'),
      // locale: Get.deviceLocale, // auto lang
      fallbackLocale: const Locale('en'),
    );
  }
}
