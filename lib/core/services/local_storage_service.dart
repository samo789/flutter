import 'dart:convert';
import 'package:ads_app/core/data/models/language_model.dart';
import 'package:ads_app/core/enums/data_type.dart';
import 'package:ads_app/core/data/models/apis/login_model.dart';
import 'package:ads_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static String email = 'email';
  static String accessToken = 'accessToken';
  static String rememberMe = 'rememberMe';
  static String loggedIn = 'loggedIn';
  static String app_language = 'language';

  final SharedPreferences sharedPreferences;

  LocalStorageService({required this.sharedPreferences});

  String getEmail() {
    return get(key: email) ?? '';
  }

  void setEmail({required String value}) {
    set(type: DataType.string, key: email, value: value);
  }

  bool getRememberMe() {
    return get(key: rememberMe) ?? false;
  }

  void setRememberMe({required bool value}) {
    set(type: DataType.bool, key: rememberMe, value: value);
  }

  bool getLoggedIn() {
    return get(key: loggedIn) ?? false;
  }

  void setLoggedIn({required bool value}) {
    set(type: DataType.bool, key: loggedIn, value: value);
  }

  String getAccessToken() {
    return get(key: accessToken) ?? '';
  }

  void setAccessToken({required String accessTokenValue}) {
    set(type: DataType.string, key: accessToken, value: accessTokenValue);
  }

  void saveAppLanguage({required LanguageModel langModel}) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data = LanguageModel.toMap(langModel);
    String language = jsonEncode(data);
    set(type: DataType.string, key: app_language, value: language);
  }

  LanguageModel? getAppLanguage() {
    if (sharedPreferences!.containsKey(app_language)) {
      Map<String, dynamic> userMap = jsonDecode(get(key: app_language));
      LanguageModel languageModel = LanguageModel.fromJson(userMap);
      return languageModel;
    } else {
      return LanguageModel(id: "QlE9PQ==", culture: "ar", isActive: true);
    }
  }

  Future<void> set({
    required DataType type,
    required String key,
    required dynamic value,
  }) async {
    switch (type) {
      case DataType.int:
        await sharedPreferences.setInt(key, value);
        break;
      case DataType.string:
        await sharedPreferences.setString(key, value);
        break;
      case DataType.bool:
        await sharedPreferences.setBool(key, value);
        break;
      case DataType.double:
        await sharedPreferences.setDouble(key, value);
        break;
      case DataType.stringList:
        await sharedPreferences.setStringList(key, value);
        break;
    }
  }

  dynamic get({required String key}) {
    return sharedPreferences.get(key);
  }

  void remove({required String key}) async {
    await sharedPreferences.remove(key);
  }

  Future<void> clear() async {
    await sharedPreferences.clear();
  }
}
