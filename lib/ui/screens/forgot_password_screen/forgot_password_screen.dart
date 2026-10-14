import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ads_app/shared_widgets/app_button.dart';
import 'package:ads_app/shared_widgets/app_text_field.dart';
import 'package:ads_app/shared_widgets/colors.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

 return GetBuilder<ForgotPasswordController>(
      init: Get.find<ForgotPasswordController>(), 
      builder: (controller) {
        return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(backgroundColor: AppColors.white, elevation: 0),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: controller.formKey,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              
                const Text('استعادة كلمة المرور', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('أدخل بريدك الإلكتروني وسنرسل إليك رمز تحقق مكوناً من 6 أرقام ', 
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 36),
                
                AppTextField(
                  controller: emailController,
                  hintText: 'البريد الإلكتروني',
                  prefixIcon: const Icon(CupertinoIcons.mail, color: Color(0xffB0B0B0), size: 20),
                  validator: (value) => value!.isEmpty ? 'البريد الإلكتروني مطلوب' : null,
                ),
                const SizedBox(height: 40),
                
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator(color: AppColors.primaryColor)
                    : SizedBox(
                        width: 354, height: 45,
                        child: AppButton(
                          text: 'إرسال الرمز',
                          textColor: AppColors.white,
                          backgroundColor: AppColors.primaryColor,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.requestOtp(email: emailController.text);
                            }
                          },
                        ),
                      )),
                      const SizedBox(height: 32),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text('تذكرت كلمة المرور؟ ', style: TextStyle(fontSize: 12, color: Colors.black)),
    InkWell(
      onTap: () => Get.back(), // أو الانتقال لصفحة Login بـ Get.offAllNamed
      child: const Text(
        'تسجيل الدخول',
        style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
      ),
    ),
  ],
),

              ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}