import 'package:department_web/controller/auth_controller.dart';
import 'package:department_web/extension.dart';
import 'package:department_web/view/widget/custom_button.dart';
import 'package:department_web/view/widget/custom_text.dart';
import 'package:department_web/view/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              txt: "تسجيل الدخول الى حسابك",
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 46),
            CustomTextFormField(
              hintTxt: "الايميل",
              label: "الايميل",
              controller: controller.email,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintTxt: "كلمة السر",
              label: "كلمة السر",
              obscureText: controller.showPassword,
              controller: controller.password,
              suffixIcon: InkWell(
                onTap: () => controller.changeShowPassword(),
                child: Icon(controller.showPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              width: double.infinity,
              borderRadius: 12,
              high: 56,
              child: const Center(
                child: CustomText(
                  txt: "تسجيل الدخول",
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () => controller.loginUser(context),
            ),
          ],
        ).paddingDesk(context, 0.0, 140.w).paddingMobile(context, 0.0, 16.w),
      );
    });
  }
}
