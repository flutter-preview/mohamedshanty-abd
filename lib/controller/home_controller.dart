import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:department_web/controller/auth_controller.dart';
import 'package:department_web/controller/services/save_user.dart';
import 'package:department_web/models/post_model.dart';
import 'package:department_web/util/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'services/firebase_service/firebase_service.dart';

class HomeUserController extends GetxController {
  bool loading = false;
  String screen = "posts", fileName = "", chooseDepartment = "";
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  Uint8List? bytes;
  List<PostModel> posts = [];
  late BuildContext context;
  AuthController authController = Get.find();

  HomeUserController(this.context);

  changeScreen(String screenInput) {
    screen = screenInput;
    update();
  }

  changeDepartment(String categoryInput) {
    chooseDepartment = categoryInput;
    update();
  }

  addBytes(Uint8List input, String fileNameInput) {
    bytes = input;
    fileName = fileNameInput;
    update();
  }

  getPosts() async {
    posts = [];
    String departmentUser = await IdRepository.get("department");
    if (departmentUser.isNotEmpty) {
      loading = true;
      update();
      if (authController.user?.role != "admin") {
        await FirebaseFirestore.instance
            .collection(ConstData.postsCollection)
            .where(
              "department",
              isEqualTo: departmentUser,
            )
            .get()
            .then((value) {
          for (var element in value.docs) {
            posts.add(PostModel.fromMap(element.data()));
            update();
          }
          loading = false;
          update();
        });
      } else {
        await FirebaseFirestore.instance
            .collection(ConstData.postsCollection)
            .get()
            .then((value) {
          for (var element in value.docs) {
            posts.add(PostModel.fromMap(element.data()));
            update();
          }
          loading = false;
          update();
        });
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
    loading = false;
    update();
  }

  addPost() async {
    if (title.text.trim().isEmpty) {
      Get.snackbar(
        "Message",
        "Title is empty",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else if (description.text.trim().isEmpty) {
      Get.snackbar(
        "Message",
        "Description is empty",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else if (fileName.trim().isEmpty) {
      Get.snackbar(
        "Message",
        "File is empty",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      String postLink = await FirebaseService.addToStorage(fileName, bytes!);
      String id = ConstData.getRandomString(12);
      var department = await IdRepository.get("department");
      Map<String, dynamic> data = {
        "id": id,
        "title": title.text,
        "description": description.text,
        "department": authController.user?.role == "admin"
            ? chooseDepartment
            : department,
        "link": postLink,
      };

      await FirebaseFirestore.instance
          .collection(ConstData.postsCollection)
          .doc(id)
          .set(data)
          .then((value) async {
        await getPosts();
        EasyLoading.dismiss(animation: true);
        bytes = null;
        fileName = "";
        title.clear();
        description.clear();
        changeDepartment("");
        update();
      }).catchError((e) {
        Get.snackbar(
          "Error",
          e.toString(),
        );
        EasyLoading.dismiss(animation: true);
      });
    }
  }

  deletePost(String idPost) async {
    await FirebaseFirestore.instance
        .collection(ConstData.postsCollection)
        .doc(idPost)
        .delete()
        .then((value) async => getPosts());
  }

  checkUser() async {
    String role = await IdRepository.get("role");
    if (role.isNotEmpty) {
      getPosts();
    } else {
      Navigator.restorablePushReplacementNamed(context, "/");
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkUser();
  }
}
