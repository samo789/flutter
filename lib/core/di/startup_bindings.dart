import 'package:ads_app/core/data/repository/home_repository.dart';
import 'package:ads_app/core/data/repository/lookups_repository.dart';
import 'package:ads_app/core/services/google_sign_in_service.dart';
import 'package:ads_app/ui/screens/forgot_password_screen/forgot_password_controller.dart';
import 'package:ads_app/ui/screens/reset_password_screen/reset_password_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/core/services/api_serivce.dart';
import 'package:ads_app/core/services/local_storage_service.dart';
import 'package:ads_app/ui/screens/login_screen/login_controller.dart';
import 'package:ads_app/ui/screens/create_screen/create_controller.dart'; 

class StartupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository(),fenix: true,);
    Get.lazyPut<LoginController>(() => LoginController(),fenix: true,);
    Get.lazyPut<CreateController>(() => CreateController(),fenix: true,);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(),fenix: true,);
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController(),fenix: true,);
    Get.lazyPut<GoogleSignInService>(() => GoogleSignInService(),fenix: true,);
    
    Get.lazyPut<HomeRepository>(() => HomeRepository(),fenix: true,);
    Get.lazyPut<LookupsRepository>(() => LookupsRepository(),fenix: true,);



  }
}
