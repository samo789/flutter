class ResetPasswordResponseModel {
  String? requestId;
  String? data;
  String? extraCode;
  List<Errors>? errors;

 ResetPasswordResponseModel({this.requestId, this.data, this.extraCode, this.errors});

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    data = json['data'];
    extraCode = json['extra_code'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['data'] = this.data;
    data['extra_code'] = this.extraCode;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String? key;
  String? message;

  Errors({this.key, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['message'] = this.message;
    return data;
  }
}