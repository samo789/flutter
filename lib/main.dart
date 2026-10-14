import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ads_app/core/di/startup_bindings.dart';
import 'package:ads_app/core/services/api_serivce.dart';
import 'package:ads_app/core/services/local_storage_service.dart';
import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/ui/screens/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await GoogleSignIn.instance.initialize(
    serverClientId: '820273665076-eb09qvqqpphug72cshipdl86gu0l8179.apps.googleusercontent.com',
  );


  final sharedPrefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPrefs,);
  Get.put<LocalStorageService>(LocalStorageService(sharedPreferences: sharedPrefs),);
  Get.put<ApiService>(ApiService(),);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorageService storage = Get.find<LocalStorageService>();
    String currentCulture = storage.getAppLanguage()?.culture ?? 'ar';
    Locale initialLocale = currentCulture == 'en' ? const Locale('en', 'US') : const Locale('ar', 'SA');

    return GetMaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      initialBinding: StartupBindings(),
      locale: initialLocale,
      fallbackLocale: const Locale('ar', 'SA'),

      home: LoginScreen(), 
      
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),

      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      textDirection: initialLocale == const Locale('ar', 'SA')
          ? TextDirection.rtl
          : TextDirection.ltr,

      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
