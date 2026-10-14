# تعديلات واجهة الشروط والأحكام والخصوصية

**الأرشيف الأساسي:** `ads_app(3).rar`  
**نطاق هذا التحديث:** واجهة شاشة **إنشاء حساب** وروابط الشروط والأحكام وسياسة الخصوصية فقط.

> تم الالتزام بعدم تعديل طبقة الـ API التي أضافها الفريق. لا يوجد تغيير في endpoints أو models أو repository أو network service.

---

## السلوك النهائي

في أسفل شاشة **إنشاء حساب** يظهر النص:

> بالمتابعة، أنت توافق على الشروط والأحكام وسياسة الخصوصية

- **الشروط والأحكام** و**سياسة الخصوصية** رابطان قابلان للضغط.
- عند الضغط، يستدعي `CreateController` دالة الفريق الموجودة مسبقاً:
  ```dart
  AuthRepository.getContentLinks()
  ```
- تستخدم الدالة نفسها الـ API الموجود مسبقاً `GET /api/content/links`.
- يجري فتح `termsUrl` أو `privacyUrl` الذي يعيده الـ API عبر `url_launcher`.
  - على Android: يفتح المتصفح/الطريقة الافتراضية للنظام.
  - على الويب: يفتح في تبويب جديد (`_blank`).
- أثناء جلب الرابط يظهر مؤشر تحميل صغير، وتتوقف الروابط مؤقتاً لمنع تكرار الطلب.
- روابط المحتوى تُحفظ مؤقتاً داخل `CreateController` ما دامت شاشة إنشاء الحساب مفتوحة، لذلك لا يتكرر طلب API عند الضغط على الرابط الثاني.
- إذا كان الرابط فارغاً أو بصيغة غير آمنة (غير `http` أو `https`) تظهر رسالة عربية مناسبة بدلاً من حصول خطأ.

---

## التعديلات التي تمت على الكود الأساسي

| الملف | نوع التعديل | التفاصيل |
|---|---|---|
| `lib/shared_widgets/terms_and_privacy_links.dart` | **ملف جديد** | مكوّن UI مستقل وقابل لإعادة الاستخدام لسطر الموافقة والروابط. لا يحتوي API أو منطق شبكة. يدعم التفاف النص على الشاشات الصغيرة، ويحوي Semantic labels للوصولية. |
| `lib/ui/screens/create_screen/create_screen.dart` | **تعديل واجهة** | تنظيف كامل لترتيب شاشة إنشاء الحساب، وحذف استدعاء API المكرر من الواجهة، ثم استخدام `TermsAndPrivacyLinks` في أسفل الشاشة. لا يوجد في الشاشة الآن `AuthRepository` أو `launchUrl` أو `getContentLinks`. |
| `lib/ui/screens/create_screen/create_controller.dart` | **تعديل محدود للربط** | نقل متحكمات حقول النص إلى الـ controller وإتلافها في `onClose`، ونقل التحقق قبل التسجيل إلى `registerUser()`، وإضافة `openPolicyLink()` لاستدعاء API الموجود وفتح الرابط. |
| `test/widget_test.dart` | **اختبار واجهة** | استبدال اختبار العداد الافتراضي باختبار يتأكد أن رابطَي الشروط والخصوصية يظهران ويستجيبان للضغط، واختبار حالة التحميل. |
| `pubspec.lock` | **تحديث آلي للحزم العابرة فقط** | حدث أثناء `flutter pub get` بإصدار Flutter الحالي؛ لم تتغير `pubspec.yaml` ولم تُضف أي dependency جديدة. |

## تفاصيل تنظيف `CreateController`

التغيير هنا تنظيمي داخل واجهة إنشاء الحساب فقط، ولا يغيّر عقد الـ API:

1. `TextEditingController` الخاصة بالاسم والبريد وكلمات المرور لم تعد تنشأ داخل `build`؛ أصبحت حقولاً في `CreateController` وتُغلق عبر `dispose` في `onClose`.
2. بقي طلب التسجيل نفسه كما هو من API الفريق (`register` وبنفس الحقول المرسلة).
3. نقل شرط `formKey.validate()` إلى `registerUser()` جعل الزر أبسط ومنع تكرار التحقق بين UI والـ controller.
4. تجميع فتح الشروط والخصوصية في دالة واحدة `openPolicyLink(PolicyLinkType)` ألغى التكرار الذي كان موجوداً مرتين في `create_screen.dart`.

---

## ملفات لم تتغير عمداً

لم يتم تعديل أي ملف في القائمة التالية:

```text
lib/core/data/repository/auth_repository.dart
lib/core/data/models/apis/content_links_response_model.dart
lib/core/data/network/endpoints/auth_endpoints.dart
lib/core/data/network/network_config.dart
lib/core/services/api_serivce.dart
lib/core/data/models/common_response.dart
lib/main.dart
lib/ui/screens/login_screen/*
lib/ui/screens/forgot_password_screen/*
lib/ui/screens/reset_password_screen/*
lib/ui/screens/home_screen/*
pubspec.yaml
```

وبالتالي:

- **لم يتغير** endpoint `content/links`.
- **لم يتغير** شكل الاستجابة أو `terms_url` و`privacy_url`.
- **لم تتغير** APIs نسيان كلمة المرور أو إعادة تعيين كلمة المرور.
- **لم تُضف** `terms_accepted` إلى طلب إنشاء الحساب.
- **لم يُضف** مربع اختيار إلزامي، لأن تصميم الفريق الحالي يعتمد عبارة الموافقة فقط.
- **لم يُضف** دعم web platform أو أي ملف native جديد؛ هذا التحديث يقتصر على UI الشروط وملفاته المرتبطة.

---

## تحقق الجودة

تم التحقق من الملفات المعدلة فقط بواسطة:

```bash
flutter analyze \
  lib/ui/screens/create_screen/create_controller.dart \
  lib/ui/screens/create_screen/create_screen.dart \
  lib/shared_widgets/terms_and_privacy_links.dart \
  test/widget_test.dart
```

**النتيجة:** `No issues found!`

وتم تنفيذ:

```bash
flutter test
```

**النتيجة:** `2 tests passed`.

> تحليل المشروع كاملاً يظهر ملاحظات قديمة في ملفات لم يجر تعديلها، مثل `api_serivce.dart` و`common_response.dart` وبعض الـ models. لم ألمسها التزاماً بنطاق المهمة وملكية الفريق للـ APIs.
