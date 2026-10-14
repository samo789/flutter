class ContentLinksResponseModel {
  String? termsUrl;
  String? privacyUrl;

  ContentLinksResponseModel({this.termsUrl, this.privacyUrl});

  ContentLinksResponseModel.fromJson(Map<String, dynamic> json) {
    termsUrl = json['terms_url'];
    privacyUrl = json['privacy_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['terms_url'] = termsUrl;
    data['privacy_url'] = privacyUrl;
    return data;
  }
}
