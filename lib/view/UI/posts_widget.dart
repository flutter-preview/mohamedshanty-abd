import 'dart:js' as js;

import 'package:department_web/controller/home_controller.dart';
import 'package:department_web/models/post_model.dart';
import 'package:department_web/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsWidget extends StatelessWidget {
  final PostModel post;

  const PostsWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txt: post.title,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 24),
              CustomText(txt: post.description),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => js.context.callMethod('open', [post.link]),
                child: const CustomText(
                  txt: "Download file",
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          GetBuilder<HomeUserController>(
            builder: (controller) {
              return IconButton(
                onPressed: () => controller.deletePost(post.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
