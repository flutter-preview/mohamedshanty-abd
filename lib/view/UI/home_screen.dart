import 'package:department_web/controller/home_controller.dart';
import 'package:department_web/controller/services/save_user.dart';
import 'package:department_web/extension.dart';
import 'package:department_web/view/UI/add_post_widget_user.dart';
import 'package:department_web/view/UI/posts_widget.dart';
import 'package:department_web/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeUserController>(
      init: HomeUserController(context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await IdRepository.remove("role");

                        Navigator.restorablePushReplacementNamed(context, "/");
                      },
                      icon: const Icon(
                        Icons.login,
                        color: Colors.red,
                      ),
                    ),
                    const CustomText(
                      txt: "تسجيل خروج",
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changeScreen("posts"),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: controller.screen == "posts"
                                ? Colors.teal
                                : Colors.transparent,
                            border: Border.all(
                              color: controller.screen == "posts"
                                  ? Colors.transparent
                                  : Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CustomText(
                              txt: "المنشورات",
                              color: controller.screen == "posts"
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changeScreen("addPost"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.screen != "posts"
                                ? Colors.teal
                                : Colors.transparent,
                            border: Border.all(
                              color: controller.screen != "posts"
                                  ? Colors.transparent
                                  : Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 56,
                          child: Center(
                            child: CustomText(
                              txt: "اضافة منشور",
                              color: controller.screen != "posts"
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                controller.loading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: CircularProgressIndicator(),
                      )
                    : controller.screen == "posts"
                        ? Column(
                            children: [
                              const SizedBox(height: 24),
                              ...controller.posts
                                  .map((e) => PostsWidget(post: e))
                                  .toList()
                            ],
                          )
                        : const AddPostWidgetUser(),
              ],
            )
                .paddingDesk(context, 24.h, 80.w)
                .paddingMobile(context, 12.h, 16.w),
          ),
        );
      },
    );
  }
}
