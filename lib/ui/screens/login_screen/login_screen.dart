import 'package:ads_app/shared_widgets/app_button.dart';
import 'package:ads_app/shared_widgets/app_text_field.dart';
import 'package:ads_app/shared_widgets/colors.dart';
import 'package:ads_app/shared_widgets/social_button.dart';
import 'package:ads_app/ui/screens/create_screen/create_controller.dart';
import 'package:ads_app/ui/screens/create_screen/create_screen.dart';
import 'package:ads_app/ui/screens/forgot_password_screen/forgot_password_controller.dart';
import 'package:ads_app/ui/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return GetBuilder<LoginController>(
      init: Get.find<LoginController>(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Logo',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 19),

                        const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'أدخل بريدك الإلكتروني وكلمة المرور',
                          style: TextStyle(fontSize: 12, color: Color(0xff8E8E8E)),
                        ),
                        const SizedBox(height: 36),

                        AppTextField(
                          controller: _emailController,
                          hintText: 'البريد الإلكتروني',
                          prefixIcon: const Icon(Icons.email_outlined, color: Color(0xffB0B0B0), size: 20),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'email_required'.tr;
                            }
                            if (!controller.emailReq.hasMatch(value)) {
                              return 'email_invalid'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 27),

                        Obx(() => AppTextField(
                            controller: _passwordController,
                            hintText: 'كلمة المرور',
                            obscureText: !controller.showPassword.value,
                            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xffB0B0B0), size: 20),
                            suffixIcon: InkWell(
                              onTap: () => controller.showPassword.toggle(),
                              child: Icon(
                                controller.showPassword.value ? Icons.visibility_off : Icons.remove_red_eye,
                                color: const Color(0xffB0B0B0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password_required'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 7),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => ForgotPasswordScreen()); 
                            },
                            child: const Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),

                        Obx(() => !controller.isLoading.value
                            ? AppButton(
                                text: 'تسجيل',
                                textColor: Colors.white,
                                onPressed: () {
                                  if (controller.formKey.currentState != null && !controller.formKey.currentState!.validate()) {
                                    Get.snackbar(
                                      'تنبيه',
                                      'يرجى التحقق من صحة الحقول المدخلة',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(16),
                                    );
                                  } else {
                                    controller.loginAction(
                                      sEmail: _emailController.text,
                                      sPassword: _passwordController.text,
                                    );
                                  }
                                },
                                backgroundColor: AppColors.primaryColor,
                              )
                            : const SizedBox(
                                height: 40,
                                child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                              ),
                        ),
                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 80, child: Divider(color: Color(0xffECECEC), thickness: 1)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('أو المتابعة مع', style: const TextStyle(fontSize: 9, color: Color(0xffC0C0C0))),
                            ),
                            const SizedBox(width: 80, child: Divider(color: Color(0xffECECEC), thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: SocialButton(
                                text: 'Apple',
                                logoPath: 'assets/images/apple.png',
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SocialButton(
                                text: 'Google',
                                logoPath: 'assets/images/google.png',
                                onPressed: () { controller.signInWithGoogle(); },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('ليس لديك حساب؟', style: TextStyle(fontSize: 10, color: Colors.black)),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                             Get.to(() => const CreateScreen(),
                            binding: BindingsBuilder(() {
                          Get.lazyPut<CreateController>(() => CreateController());
                             }),
                               );
                              },
                              child: const Text(
                                'إنشاء حساب',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
       ),
),
),
],
),
                        const SizedBox(height: 20),
],
),
),
),
),
),
),
);
},
);
}
}
