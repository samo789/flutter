import 'package:dartz/dartz.dart';
import 'package:ads_app/core/services/api_serivce.dart';
import 'package:ads_app/core/data/network/network_config.dart';
import 'package:ads_app/core/data/network/endpoints/auth_endpoints.dart';
import 'package:ads_app/core/data/models/apis/governorate_model.dart';
import 'package:ads_app/core/data/models/error_model.dart';
import 'package:ads_app/core/data/models/common_response.dart';
import 'package:ads_app/core/enums/request_type.dart';

class LookupsRepository {
  final ApiService _apiService = ApiService();

  Future<Either<List<ErrorModel>, List<GovernorateModel>>> getGovernorates() async {
    try {
      return _apiService
          .request(
            type: RequestType.get,
            subRoute: AuthEndpoints.governorates,
            headers: NetworkConfig.getHeaders(
              needAuth: false,
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
              List data = commonResponse.data['data'] ?? [];
              return Right(
                data.map((e) => GovernorateModel.fromJson(e)).toList(),
              );
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
