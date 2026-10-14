class ForgotPasswordResponseModel {
  String? message;
  int? resendAfterSeconds;
  String? devCode;

  ForgotPasswordResponseModel({
    this.message,
    this.resendAfterSeconds,
    this.devCode,
  });

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    resendAfterSeconds = json['resend_after_seconds'];
    devCode = json['dev_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['resend_after_seconds'] = resendAfterSeconds;
    data['dev_code'] = devCode;
    return data;
  }
}
