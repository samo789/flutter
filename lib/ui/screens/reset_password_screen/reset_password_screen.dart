import 'package:ads_app/ui/screens/login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; 
import 'package:ads_app/shared_widgets/app_button.dart';
import 'package:ads_app/shared_widgets/app_text_field.dart';
import 'package:ads_app/shared_widgets/colors.dart';
import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final int initialTimerSeconds;
  

  ResetPasswordScreen({
    super.key, 
    required this.email, 
    required this.initialTimerSeconds,
  }); 
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: Get.find<ResetPasswordController>()..startTimer(initialTimerSeconds), 
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

Text.rich(
  TextSpan(
    children: [
      const TextSpan(
        text: 'أرسلنا رمز تحقق مكوّناً من 6 أرقام إلى:\n',
      ),
      TextSpan(
        text: email,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      const TextSpan(
        text: '\nأدخل الرمز وكلمة المرور الجديدة',
      ),
    ],
  ),
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontSize: 11,
    color: AppColors.greyText,
    height: 1.6,
  ),
),

const SizedBox(height: 24),
                    
                    PinCodeTextField(
                      appContext: context,
                      controller: _otpController,
                      length: 6, 
                      onChanged: (value) => controller.otpCode = value,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 45, fieldWidth: 42, 
                        borderRadius: BorderRadius.circular(12),
                        activeColor: AppColors.primaryColor,
                        inactiveColor: const Color(0xffECECEC),
                        selectedColor: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                   
                    Obx(() => Align(
                      alignment: Alignment.centerRight,
                      child: controller.isResendClickable.value
                          ? InkWell(
                              onTap: () {controller.resendOtp(email: email, otpController: _otpController,);
                               _passwordController.clear(); 
                               _confirmPasswordController.clear(); },
                              child: const Text(
                                'لم يصلك الرمز؟ إعادة إرسال الرمز', 
                                style: TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            )
                          : Text(
                              'لم يصلك الرمز؟ إعادة الإرسال بعد 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}', 
                              style: const TextStyle(fontSize: 11, color: Color(0xff8E8E8E)),
                            ),
                    )),

                    const SizedBox(height: 24),
                   
                         Container(
                        height: 1,                  
                        color: const Color(0xffECECEC), 
                       ),

                       const SizedBox(height: 24),
                    
                     Obx(() => AppTextField(
                            controller: _passwordController,
                            hintText: 'كلمة المرور الجديدة',
                            obscureText: !controller.showPassword.value,
                            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.greyText), 
                            suffixIcon: InkWell(
                              onTap: () => controller.showPassword.toggle(),
                              child: Icon(
                                controller.showPassword.value ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
                                color: AppColors.greyText,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
                              if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 خانات على الأقل';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                      
                        Obx(() => AppTextField(
                            controller: _confirmPasswordController,
                            hintText: 'تأكيد كلمة المرور الجديدة',
                            obscureText: !controller.showConfirmPassword.value,
                            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.greyText), 
                            suffixIcon: InkWell(
                              onTap: () => controller.showConfirmPassword.toggle(),
                              child: Icon(
                                controller.showConfirmPassword.value 
                                ? Icons.visibility_off_outlined 
                                : Icons.remove_red_eye_outlined,
                                color: AppColors.greyText,
                              ),
                            ), 
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'يرجى تأكيد كلمة المرور';
                              if (value != _passwordController.text) return 'كلمتا المرور غير متطابقتين';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 28),
                    
                    Obx(() => controller.isLoading.value
                        ? const CircularProgressIndicator(color: AppColors.primaryColor)
                        : SizedBox(
                            width: 354, height: 45,
                            child: AppButton(
                              text: 'حفظ كلمة المرور',
                              textColor: AppColors.white,
                              backgroundColor: AppColors.primaryColor,
                              onPressed: () {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.resetUserPassword(
                                    email: email,
                                    password: _passwordController.text,
                                    confirmPassword: _confirmPasswordController.text,
                                  );
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
      onTap: () => Get.offAll(() => LoginScreen()), 
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
