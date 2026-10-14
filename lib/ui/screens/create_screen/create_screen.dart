import 'package:ads_app/shared_widgets/app_button.dart';
import 'package:ads_app/shared_widgets/app_text_field.dart';
import 'package:ads_app/shared_widgets/colors.dart';
import 'package:ads_app/shared_widgets/terms_and_privacy_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_controller.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
      init: Get.find<CreateController>(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.black,
                ),
                onPressed: Get.back,
                tooltip: 'رجوع',
              ),
            ),
            body: SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildLogo(),
                            const SizedBox(height: 19),
                            const Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'أدخل المعلومات المطلوبة أدناه',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                            ),
                            const SizedBox(height: 32),
                            AppTextField(
                              controller: controller.fullNameController,
                              hintText: 'الاسم الكامل',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: AppColors.greyText,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'الرجاء إدخال الاسم الكامل';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              controller: controller.emailController,
                              hintText: 'البريد الإلكتروني',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColors.greyText,
                              ),
                              validator: (value) {
                                final email = value?.trim() ?? '';
                                if (email.isEmpty) {
                                  return 'البريد الإلكتروني مطلوب';
                                }
                                if (!controller.emailReq.hasMatch(email)) {
                                  return 'البريد الإلكتروني غير صالح';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => AppTextField(
                                controller: controller.passwordController,
                                hintText: 'كلمة المرور',
                                obscureText: !controller.showPassword.value,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.greyText,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: controller.showPassword.toggle,
                                  icon: Icon(
                                    controller.showPassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                    color: AppColors.greyText,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'كلمة المرور مطلوبة';
                                  }
                                  if (value.length < 6) {
                                    return 'كلمة المرور يجب أن تكون 6 خانات على الأقل';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => AppTextField(
                                controller:
                                    controller.confirmPasswordController,
                                hintText: 'تأكيد كلمة المرور',
                                obscureText:
                                    !controller.showConfirmPassword.value,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.greyText,
                                ),
                                suffixIcon: IconButton(
                                  onPressed:
                                      controller.showConfirmPassword.toggle,
                                  icon: Icon(
                                    controller.showConfirmPassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                    color: AppColors.greyText,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يرجى تأكيد كلمة المرور';
                                  }
                                  if (value !=
                                      controller.passwordController.text) {
                                    return 'كلمتا المرور غير متطابقتين';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 28),
                            Obx(
                              () => controller.isLoading.value
                                  ? const SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    )
                                  : AppButton(
                                      text: 'إنشاء الحساب',
                                      textColor: AppColors.white,
                                      backgroundColor: AppColors.primaryColor,
                                      onPressed: controller.registerUser,
                                    ),
                            ),
                            const SizedBox(height: 36),
                            Obx(
                              () => TermsAndPrivacyLinks(
                                isLoading: controller.isPolicyLinkLoading.value,
                                onTermsPressed: () => controller.openPolicyLink(
                                  PolicyLinkType.terms,
                                ),
                                onPrivacyPressed: () => controller
                                    .openPolicyLink(PolicyLinkType.privacy),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 86,
      height: 86,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Logo',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
