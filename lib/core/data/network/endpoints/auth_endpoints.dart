import 'package:ads_app/core/data/network/network_constants.dart';

class AuthEndpoints {
  static final String login = NetworkConstants.getFullSubRoute('auth/login');
  static final String register = NetworkConstants.getFullSubRoute('auth/register');
  static final String refresh = NetworkConstants.getFullSubRoute('auth/refresh');
  static final String forgotPassword = NetworkConstants.getFullSubRoute('auth/forgot-password');
  static final String resetPassword = NetworkConstants.getFullSubRoute('auth/reset-password');
  static final String loginWithSocial = NetworkConstants.getFullSubRoute('auth/social');
  static final String contentLinks = NetworkConstants.getFullSubRoute('content/links');

  static final String homeStats = NetworkConstants.getFullSubRoute('home/stats');
  static final String nearbyDeals = NetworkConstants.getFullSubRoute('home/nearby-deals');
  static final String recentAds = NetworkConstants.getFullSubRoute('home/recent');
  static final String governorates = NetworkConstants.getFullSubRoute('governorates');
}
