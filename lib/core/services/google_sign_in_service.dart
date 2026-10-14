import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<String?> getGoogleIdToken() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication authentication = account.authentication;
      final String? idToken = authentication.idToken;
      
      print('Google ID Token from Service');
      return idToken; 
    } catch (e) {
      print("خطأ في تسجيل الدخول بواسطة جوجل");
      return null;
    }
  }

  Future<void> signOutFromGoogle() async {
    try {
      print("تم تسجيل الخروج من حساب جوجل بنجاح");
    } catch (e) {
      print("خطأ أثناء تسجيل الخروج من جوجل");
    }
  }
}
