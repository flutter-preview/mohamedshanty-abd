import 'package:department_web/controller/auth_controller.dart';
import 'package:department_web/view/UI/home_screen.dart';
import 'package:department_web/view/UI/landing_screen.dart';
import 'package:department_web/view/UI/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  List<Map<String, dynamic>> users = [
    {
      "email": "a@gmail.com",
      "password": "123456789",
      "id": "1",
      "department": "قسم الموارد التقنية",
      "role": "user"
    },
    {
      "email": "b@gmail.com",
      "password": "12345678",
      "id": "2",
      "department": "قسم التطوير المهني و قياس الاداء",
      "role": "user"
    },
    {
      "email": "c@gmail.com",
      "password": "1234567890",
      "id": "3",
      "department": "قسم امن المعلومات و الامن السيبراني",
      "role": "user"
    },
    {
      "email": "d@gmail.com",
      "password": "12345678910",
      "id": "4",
      "department": "قسم التعليم الالكتروني و التعليم عن بعد",
      "role": "user"
    },
    {
      "email": "admin@gmail.com",
      "password": "123456789**",
      "id": "4",
      "department": "",
      "role": "admin"
    },
  ];

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 811),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Department web',
          initialRoute: '/',
          routes: {
            '/': (context) => const LandingScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const Home(),
          },
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
