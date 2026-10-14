class AdItemModel {
  String? id; 
  String? title;
  double? price;
  String? currency;
  String? status;
  String? thumbnailUrl;
  String? governorateName;
  String? categoryName;
  int? viewsCount;
  bool? isSaved;
  DateTime? createdAt;

  AdItemModel({
    this.id,
    this.title,
    this.price,
    this.currency,
    this.status,
    this.thumbnailUrl,
    this.governorateName,
    this.categoryName,
    this.viewsCount,
    this.isSaved,
    this.createdAt,
  });

  AdItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] as num?)?.toDouble();
    currency = json['currency'];
    status = json['status'];
    thumbnailUrl = json['thumbnail_url'];
    governorateName = json['governorate_name'];
    categoryName = json['category_name'];
    viewsCount = json['views_count'];
    isSaved = json['is_saved'];
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['currency'] = currency;
    data['status'] = status;
    data['thumbnail_url'] = thumbnailUrl;
    data['governorate_name'] = governorateName;
    data['category_name'] = categoryName;
    data['views_count'] = viewsCount;
    data['is_saved'] = isSaved;
    data['created_at'] = createdAt?.toString();
    return data;
  }
}
