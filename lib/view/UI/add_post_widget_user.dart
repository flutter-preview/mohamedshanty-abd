import 'package:department_web/controller/auth_controller.dart';
import 'package:department_web/controller/home_controller.dart';
import 'package:department_web/view/widget/custom_button.dart';
import 'package:department_web/view/widget/custom_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/custom_text.dart';

class AddPostWidgetUser extends StatelessWidget {
  const AddPostWidgetUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeUserController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            CustomTextFormField(
              hintTxt: "العنوان",
              label: "العنوان",
              controller: controller.title,
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              hintTxt: "الوصف",
              label: "الوصف",
              controller: controller.description,
            ),
            const SizedBox(height: 24),
            CustomText(
              txt: controller.fileName.isEmpty
                  ? "لم يتم تحديد ملف"
                  : "${controller.fileName} تم تحديد ",
            ),
            const SizedBox(height: 24),
            GetBuilder<AuthController>(builder: (logic) {
              return logic.user?.role == "admin"
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    txt: "اختيار صنف",
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                  const SizedBox(height: 24),
                  ...[
                    "قسم الموارد التقنية",
                    "قسم التطوير المهني و قياس الاداء",
                    "قسم امن المعلومات و الامن السيبراني",
                    "قسم التعليم الالكتروني و التعليم عن بعد",
                  ]
                      .map(
                        (e) =>
                        InkWell(
                          onTap: () => controller.changeDepartment(e),
                          child: Container(
                            margin:
                            const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 24),
                            decoration: BoxDecoration(
                              color: controller.chooseDepartment == e
                                  ? Colors.teal
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.teal,
                              ),
                            ),
                            child: CustomText(
                              txt: e,
                              color: controller.chooseDepartment == e
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                  )
                      .toList(),
                  const SizedBox(height: 24),
                ],
              )
                  : const SizedBox();
            },),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: 331,
                    borderRadius: 8,
                    high: 56,
                    child: const Center(
                      child: CustomText(
                        txt: "اضف ملف",
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);

                      if (result != null) {
                        PlatformFile file = result.files.first;
                        controller.addBytes(file.bytes!, file.name);
                      } else {
                        print("No file selected .....");
                      }
                    },
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: CustomButton(
                    width: 331,
                    borderRadius: 8,
                    high: 56,
                    child: const Center(
                      child: CustomText(
                        txt: "نشر البوست",
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async => controller.addPost(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
