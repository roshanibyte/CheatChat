import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilaizedFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'test',
        theme: ThemeData(
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStatePropertyAll(
            //       Colors.amber,
            //     ),
            //   ),
            // ),
            useMaterial3: false,
            appBarTheme: AppBarTheme(
              elevation: 1,
              backgroundColor: Colors.grey.shade600,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )),
        home: const SplashScreen(),
      ),
    );
  }
}

initilaizedFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: "ChapApp",
  );
}
