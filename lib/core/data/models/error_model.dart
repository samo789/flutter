class ErrorModel {
  String? key;
  String? message;

  ErrorModel({this.key, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['key'] = this.key;
    data['message'] = this.message;
    return data;
  }
}
