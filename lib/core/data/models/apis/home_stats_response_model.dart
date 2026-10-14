class HomeStatsModel {
  int? carsCount;
  int? realEstateCount;

  HomeStatsModel({
    this.carsCount,
    this.realEstateCount,
  });

  HomeStatsModel.fromJson(Map<String, dynamic> json) {
    carsCount = json['cars_count'];
    realEstateCount = json['real_estate_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cars_count'] = this.carsCount;
    data['real_estate_count'] = this.realEstateCount;
    return data;
  }
}
