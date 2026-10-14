import 'package:ads_app/core/data/models/apis/governorate_model.dart';
import 'package:dartz/dartz.dart';
import 'package:ads_app/core/services/api_serivce.dart';
import 'package:ads_app/core/data/network/network_config.dart';
import 'package:ads_app/core/data/network/endpoints/auth_endpoints.dart';
import 'package:ads_app/core/data/models/apis/home_stats_response_model.dart';
import 'package:ads_app/core/data/models/apis/ads_list_response_model.dart';
import 'package:ads_app/core/data/models/error_model.dart';
import 'package:ads_app/core/data/models/common_response.dart';
import 'package:ads_app/core/enums/request_type.dart';

class HomeRepository {
  final ApiService _apiService = ApiService();

  Future<Either<List<ErrorModel>, HomeStatsModel>> getHomeStats() async {
    try {
      return _apiService
          .request(
            type: RequestType.get,
            subRoute: AuthEndpoints.homeStats,
            headers: NetworkConfig.getHeaders(
              needAuth: true,
              type: RequestType.get,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            body: null,
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(
              response,
            );

            if (commonResponse.getStatus) {
              return Right(HomeStatsModel.fromJson(commonResponse.data));
            } else {
              Map<String, List<ErrorModel>> map = {};
              map[commonResponse.extraCode ?? ''] = commonResponse.getError;
              return Left(commonResponse.getError);
            }
          });
    } catch (e) {
      print(e.toString());
      return Left([ErrorModel(message: e.toString())]);
    }
  }

  Future<Either<List<ErrorModel>, List<AdItemModel>>> getNearbyDeals({
    double? lat,
    double? lng,
    String? governorateId,
    int limit = 10,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.get,
            subRoute: AuthEndpoints.nearbyDeals,
            headers: NetworkConfig.getHeaders(
              needAuth: true,
              type: RequestType.get,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            params: {
              if (lat != null) "lat": lat.toString(),
              if (lng != null) "lng": lng.toString(),
              if (governorateId != null) "governorate_id": governorateId,
              "limit": limit.toString(),
            },
            body: null,
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(
              response,
            );

            if (commonResponse.getStatus) {
              List data = commonResponse.data ?? [];
              return Right(data.map((e) => AdItemModel.fromJson(e)).toList());
            } else {
              Map<String, List<ErrorModel>> map = {};
              map[commonResponse.extraCode ?? ''] = commonResponse.getError;
              return Left(commonResponse.getError);
            }
          });
    } catch (e) {
      print(e.toString());
      return Left([ErrorModel(message: e.toString())]);
    }
  }

  Future<Either<List<ErrorModel>, List<AdItemModel>>> getRecentAds({
    String? governorateId,
    int limit = 10,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.get,
            subRoute: AuthEndpoints.recentAds,
            headers: NetworkConfig.getHeaders(
              needAuth: true,
              type: RequestType.get,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            params: {
              if (governorateId != null) "governorate_id": governorateId,
              "limit": limit.toString(),
            },
            body: null,
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(
              response,
            );

            if (commonResponse.getStatus) {
              List data = commonResponse.data ?? [];
              return Right(data.map((e) => AdItemModel.fromJson(e)).toList());
            } else {
              Map<String, List<ErrorModel>> map = {};
              map[commonResponse.extraCode ?? ''] = commonResponse.getError;
              return Left(commonResponse.getError);
            }
          });
    } catch (e) {
      print(e.toString());
      return Left([ErrorModel(message: e.toString())]);
    }
  }

}
