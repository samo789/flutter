import 'dart:async'; // 👈 إجبارية لتشغيل الـ Timer
import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/ui/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  late GlobalKey<FormState> formKey;
  late AuthRepository _authRepository;

  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  
  String otpCode = ""; 

  Timer? _timer;
  RxInt secondsRemaining = 60.obs;
  RxBool isResendClickable = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authRepository = Get.find<AuthRepository>();
    formKey = GlobalKey<FormState>();
  }

  void startTimer(int customSeconds) {
    secondsRemaining.value = customSeconds;
    isResendClickable.value = false;
    _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendClickable.value = true;
        _timer?.cancel();
      }
    });
  }

  Future<void> resendOtp({
    required String email, 
    required TextEditingController otpController,
  }) async {
    if (!isResendClickable.value) return;
    
    isLoading.value = true;
    final result = await _authRepository.forgotPassword(email: email);
    isLoading.value = false;

    result.fold(
      (errors) => Get.snackbar(
        'خطأ', 
        'فشل إعادة إرسال الرمز', 
        backgroundColor: Colors.red, 
        colorText: Colors.white
      ),
      (successModel) { 
       
        int newSeconds = successModel.resendAfterSeconds ?? 60;
        String backupCode = successModel.devCode ?? '';

        Get.snackbar(
          'نجاح', 
          'تم تجديد الرمز بنجاح. كود التجربة: $backupCode', 
          backgroundColor: Colors.green, 
          colorText: Colors.white,
          duration: const Duration(seconds: 8),
        );

        otpCode = ""; 
        otpController.clear();
        
        startTimer(newSeconds); 
      },
    );
  }

  Future<void> resetUserPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    
    if (otpCode.length < 6) {
      Get.snackbar(
        'تنبيه', 
        'يرجى إدخال رمز التحقق كاملاً المكون من 6 أرقام', 
        backgroundColor: Colors.orange, 
        colorText: Colors.white
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'خطأ بالتحقق', 
        'كلمتا المرور غير متطابقتين', 
        backgroundColor: Colors.red, 
        colorText: Colors.white
      );
      return;
    }

    isLoading.value = true;

    final result = await _authRepository.resetPassword(
      email: email,
      code: otpCode,
      password: password.trim(),
      passwordConfirmation: confirmPassword.trim(),
    );

    isLoading.value = false;

    result.fold(
      (errors) {
        Get.snackbar(
          'خطأ',
          errors.isNotEmpty ? (errors.first.message ?? 'فشلت العملية') : 'الرمز المدخل غير صحيح أو انتهت صلاحيته',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (successModel) {
       
        String successMessage = successModel.isNotEmpty ? successModel : 'تم تغيير كلمة المرور بنجاح!';

        Get.snackbar(
          'نجاح',
          successMessage,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        
        Get.offAll(() => LoginScreen());
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel(); 
    super.onClose();
  }
}
