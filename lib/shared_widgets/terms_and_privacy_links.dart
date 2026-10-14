import 'package:ads_app/shared_widgets/colors.dart';
import 'package:flutter/material.dart';

/// سطر موافقة صغير وقابل لإعادة الاستخدام في شاشات المصادقة.
///
/// لا يحتوي هذا المكوّن على أي طلبات شبكة؛ الشاشة أو الـ controller الذي
/// يستعمله هو المسؤول عن جلب الرابط وفتحه.
class TermsAndPrivacyLinks extends StatelessWidget {
  const TermsAndPrivacyLinks({
    super.key,
    required this.onTermsPressed,
    required this.onPrivacyPressed,
    this.isLoading = false,
  });

  final VoidCallback onTermsPressed;
  final VoidCallback onPrivacyPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final linkStyle = TextButton.styleFrom(
      foregroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'بالمتابعة، أنت توافق على ',
              style: TextStyle(fontSize: 11, color: AppColors.black),
            ),
            Semantics(
              button: true,
              label: 'فتح الشروط والأحكام',
              child: TextButton(
                onPressed: isLoading ? null : onTermsPressed,
                style: linkStyle,
                child: const Text(
                  'الشروط والأحكام',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const Text(
              ' و',
              style: TextStyle(fontSize: 11, color: AppColors.black),
            ),
            Semantics(
              button: true,
              label: 'فتح سياسة الخصوصية',
              child: TextButton(
                onPressed: isLoading ? null : onPrivacyPressed,
                style: linkStyle,
                child: const Text(
                  'سياسة الخصوصية',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isLoading) ...[
          const SizedBox(height: 8),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ],
    );
  }
}
