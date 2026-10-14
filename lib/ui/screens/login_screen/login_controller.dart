import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/core/services/local_storage_service.dart';
import 'package:ads_app/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ads_app/core/services/google_sign_in_service.dart'; 

class LoginController extends GetxController {
  String? loginLable = 'تسجيل الدخول';
  
  late RegExp emailReq;
  late GlobalKey<FormState> formKey;
  
  late LocalStorageService localStorageService;
  late AuthRepository _authRepository;

  late GoogleSignInService _googleSignInService;

  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    localStorageService = Get.find<LocalStorageService>();
    _authRepository = Get.find<AuthRepository>();
     _googleSignInService = Get.find<GoogleSignInService>(); 
    
    formKey = GlobalKey<FormState>();

    emailReq = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
  }

  Future<void> loginAction({required String sEmail, required String sPassword}) async {
    isLoading.value = true; 

    final result = await _authRepository.login(
      email: sEmail.trim(),
      password: sPassword.trim(),
    );

    isLoading.value = false; 

    result.fold(
      (errors) {
        Get.snackbar(
          'خطأ',
          errors.isNotEmpty ? (errors.first.message ?? 'فشل تسجيل الدخول') : 'حدث خطأ ما',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (tokenInfo) {
        
        localStorageService.setEmail(value: sEmail.trim());
        localStorageService.setLoggedIn(value: true);
        localStorageService.setAccessToken(
          accessTokenValue: tokenInfo.accessToken ?? '',
        );

        Get.offAll(() => const HomeScreen());
      },
    );
  }
  Future<void> signInWithGoogle() async { 
    try { 
     isLoading.value = true; 
      final String? idToken = await _googleSignInService.getGoogleIdToken();

      if (idToken != null) {
        final result = await _authRepository.loginWithSocial(idToken: idToken);

        result.fold(
          (errors) {
            Get.snackbar(
              'خطأ في المصادقة',
              errors.isNotEmpty ? (errors.first.message ?? 'السيرفر رفض الـ Token') : 'فشل الربط بالسيرفر',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
          (tokenInfo) {
            localStorageService.setLoggedIn(value: true);
            localStorageService.setAccessToken(accessTokenValue: tokenInfo.accessToken ?? '');

            Get.snackbar(
              'نجاح',
              'تم تسجيل الدخول بواسطة Google بنجاح!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );

            Get.offAll(() => const HomeScreen());
          },
        );
      }
    } finally {
      isLoading.value = false; 

    } 
  }
}
