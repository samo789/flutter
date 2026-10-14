import 'package:ads_app/core/data/models/apis/content_links_response_model.dart';
import 'package:ads_app/core/data/repository/auth_repository.dart';
import 'package:ads_app/core/services/local_storage_service.dart';
import 'package:ads_app/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

enum PolicyLinkType { terms, privacy }

class CreateController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late final RegExp emailReq;
  late final LocalStorageService _localStorageService;
  late final AuthRepository _authRepository;
  ContentLinksResponseModel? _contentLinks;

  final isLoading = false.obs;
  final isPolicyLinkLoading = false.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    _localStorageService = Get.find<LocalStorageService>();
    _authRepository = Get.find<AuthRepository>();
    emailReq = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    final result = await _authRepository.register(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: confirmPasswordController.text.trim(),
    );
    isLoading.value = false;

    result.fold(
      (errors) => Get.snackbar(
        'خطأ',
        errors.isNotEmpty
            ? (errors.first.message ?? 'فشلت عملية التسجيل')
            : 'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      ),
      (tokenInfo) {
        _localStorageService.setLoggedIn(value: true);
        _localStorageService.setAccessToken(
          accessTokenValue: tokenInfo.accessToken ?? '',
        );

        Get.snackbar(
          'نجاح',
          'تم إنشاء الحساب بنجاح!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
        Get.offAll(() => const HomeScreen());
      },
    );
  }

  /// يجلب روابط المحتوى مرة واحدة فقط أثناء بقاء شاشة إنشاء الحساب مفتوحة.
  Future<void> openPolicyLink(PolicyLinkType policy) async {
    if (isPolicyLinkLoading.value) return;

    isPolicyLinkLoading.value = true;
    try {
      final links = await _getContentLinks();
      if (links == null) return;

      final link = policy == PolicyLinkType.terms
          ? links.termsUrl
          : links.privacyUrl;
      final uri = _toHttpUri(link);

      if (uri == null) {
        _showPolicyError('رابط الصفحة غير متوفر حالياً.');
        return;
      }

      final didLaunch = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
      if (!didLaunch) {
        _showPolicyError('تعذر فتح الرابط. حاول مرة أخرى.');
      }
    } catch (_) {
      _showPolicyError('تعذر فتح الرابط. تحقق من اتصال الإنترنت.');
    } finally {
      isPolicyLinkLoading.value = false;
    }
  }

  Future<ContentLinksResponseModel?> _getContentLinks() async {
    if (_contentLinks != null) return _contentLinks;

    final result = await _authRepository.getContentLinks();
    return result.fold(
      (errors) {
        _showPolicyError(
          errors.isNotEmpty
              ? (errors.first.message ?? 'تعذر تحميل روابط المحتوى.')
              : 'تعذر تحميل روابط المحتوى.',
        );
        return null;
      },
      (links) {
        _contentLinks = links;
        return links;
      },
    );
  }

  Uri? _toHttpUri(String? link) {
    final uri = Uri.tryParse(link?.trim() ?? '');
    if (uri == null || uri.host.isEmpty) return null;
    if (uri.scheme != 'https' && uri.scheme != 'http') return null;
    return uri;
  }

  void _showPolicyError(String message) {
    Get.snackbar(
      'تنبيه',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
