class GovernorateModel {
  String? id; 
  String? nameAr;
  String? nameEn;
  String? imageUrl;

  GovernorateModel({this.id, this.nameAr, this.nameEn, this.imageUrl});

  GovernorateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['image_url'] = imageUrl;
    return data;
  }
}