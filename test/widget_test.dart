import 'package:ads_app/shared_widgets/terms_and_privacy_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('تعرض روابط الشروط والخصوصية وتنفذ الضغط عليها', (tester) async {
    var openedTerms = false;
    var openedPrivacy = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TermsAndPrivacyLinks(
            onTermsPressed: () => openedTerms = true,
            onPrivacyPressed: () => openedPrivacy = true,
          ),
        ),
      ),
    );

    expect(find.text('الشروط والأحكام'), findsOneWidget);
    expect(find.text('سياسة الخصوصية'), findsOneWidget);

    await tester.tap(find.text('الشروط والأحكام'));
    await tester.tap(find.text('سياسة الخصوصية'));

    expect(openedTerms, isTrue);
    expect(openedPrivacy, isTrue);
  });

  testWidgets('تعطل الروابط وتظهر مؤشر التحميل عند جلب الرابط', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TermsAndPrivacyLinks(
            isLoading: true,
            onTermsPressed: _emptyCallback,
            onPrivacyPressed: _emptyCallback,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<TextButton>(find.byType(TextButton).first).onPressed,
      isNull,
    );
  });
}

void _emptyCallback() {}
