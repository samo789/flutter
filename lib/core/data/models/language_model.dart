import 'dart:convert';

class LanguageModel {
  String? id;
  String? name;
  String? culture;
  bool? rtl;
  late bool isActive;
  bool? defaultLanguage;
  String? iconUrl;

  LanguageModel({
    this.id,
    this.name,
    this.culture,
    this.rtl,
    required this.isActive,
    this.defaultLanguage,
    this.iconUrl,
  });

  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    culture = json['culture'];
    rtl = json['rtl'];
    isActive = json['isActive'];
    defaultLanguage = json['default'];
    iconUrl = json['iconUrl'];
  }

  static Map<String, dynamic> toMap(LanguageModel language) => {
    'id': language.id,
    'name': language.name,
    'culture': language.culture,
    'isActive': language.isActive,
    'rtl': language.rtl,
    'defaultLanguage': language.defaultLanguage,
    'iconUrl': language.iconUrl,
  };

  static String encode(List<LanguageModel> language) => json.encode(
    language
        .map<Map<String, dynamic>>((language) => LanguageModel.toMap(language))
        .toList(),
  );

  static List<LanguageModel> decode(String language) =>
      (json.decode(language) as List<dynamic>)
          .map<LanguageModel>((item) => LanguageModel.fromJson(item))
          .toList();
}
