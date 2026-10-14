import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/core/services/api_serivce.dart';
import 'package:ads_app/core/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService get apiService => Get.find<ApiService>();
AuthRepository get authRepository => Get.find<AuthRepository>();
LocalStorageService get localStorageService => Get.find<LocalStorageService>();
SharedPreferences get sharedPreferences => Get.find<SharedPreferences>();
