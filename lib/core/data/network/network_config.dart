
import 'package:ads_app/core/enums/request_type.dart';
import 'package:ads_app/core/services/local_storage_service.dart';
import 'package:get/get.dart';

class NetworkConfig {
  static const String BASE_URL = "ads-api.digisou-ltd.com";
  static const String Auth_Bearer = "Bearer ";

  static LocalStorageService sLocalStorageService = Get.find<LocalStorageService>();

  static Map<String, String> getHeaders({
    bool? needAuth = true,
    RequestType? type = RequestType.post,
    Map<String, String>? extraHeaders,
  }) {
    return {
      'Lang-Id': sLocalStorageService.getAppLanguage()?.culture ?? '',
      
      if (needAuth!) 'Authorization': sLocalStorageService.getAccessToken(),
      if (type != RequestType.get) 'Content-Type': 'application/json',

      ...extraHeaders ?? {},
      
    };
  }
}

