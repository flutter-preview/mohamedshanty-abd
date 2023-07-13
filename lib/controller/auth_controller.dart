import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:department_web/controller/services/save_user.dart';
import 'package:department_web/models/user_model.dart';
import 'package:department_web/util/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserModel? user;
  bool showPassword = true;

  void loginUser(BuildContext context) {
    EasyLoading.show(status: 'loading...');

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    )
        .then((value) async {
      final res = await FirebaseFirestore.instance
          .collection(ConstData.usersCollection)
          .where("email", isEqualTo: email.text)
          .get();

      user = UserModel.fromMap(res.docs.first.data());
      await IdRepository.save("email", user!.email);
      await IdRepository.save("department", user!.department);
      await IdRepository.save("role", user!.role);

      email.clear();
      password.clear();
      EasyLoading.dismiss(animation: true);
      Navigator.pushReplacementNamed(context, '/home');

      update();
    }).catchError((e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
      EasyLoading.dismiss(animation: true);
    });
  }

  changeShowPassword() {
    showPassword = !showPassword;
    update();
  }
}
