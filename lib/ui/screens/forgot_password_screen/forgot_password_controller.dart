import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/ui/screens/reset_password_screen/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reset_password_screen/reset_password_screen.dart';

class ForgotPasswordController extends GetxController {
  late GlobalKey<FormState> formKey;
  late RegExp emailReq;
  late AuthRepository _authRepository;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authRepository = Get.find<AuthRepository>();
    formKey = GlobalKey<FormState>();
    emailReq = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
  }

  Future<void> requestOtp({required String email}) async {
    isLoading.value = true;

    final result = await _authRepository.forgotPassword(email: email.trim());

    isLoading.value = false;

    result.fold(
      (errors) {
        Get.snackbar(
          'تنبيه',
          errors.isNotEmpty ? (errors.first.message ?? 'فشلت العملية') : 'البريد الإلكتروني غير مسجل',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (successModel) {
      
        int timerSeconds = successModel.resendAfterSeconds ?? 60;
        String backupCode = successModel.devCode ?? '';
    
        Get.snackbar(
          'نجاح',
          'تم إرسال رمز التحقق بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 8),
        );
        
       
        Get.to(
          () => ResetPasswordScreen(
            email: email.trim(),
            initialTimerSeconds: timerSeconds,
          ),
          binding: BindingsBuilder(() {
            Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
            }),
        );
      },
    );
  }
}
