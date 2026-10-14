
import 'package:ads_app/core/data/models/apis/content_links_response_model.dart';
import 'package:ads_app/core/data/models/apis/forgot_password_model.dart';
import 'package:ads_app/core/data/models/apis/login_model.dart';
import 'package:ads_app/core/data/models/common_response.dart';
import 'package:ads_app/core/data/models/error_model.dart';
import 'package:ads_app/core/data/network/endpoints/auth_endpoints.dart';
import 'package:ads_app/core/data/network/network_config.dart';
import 'package:ads_app/core/services/api_serivce.dart';
import 'package:ads_app/core/enums/request_type.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Either<List<ErrorModel>, TokenInfoModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.post,
            subRoute: AuthEndpoints.login,
            headers: NetworkConfig.getHeaders(
              needAuth: false,
              type: RequestType.post,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            body: {"email": email, "password": password},
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(
              response,
            );

            if (commonResponse.getStatus) {
              return Right(TokenInfoModel.fromJson(commonResponse.data['data']));
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

  Future<Either<List<ErrorModel>, TokenInfoModel>> register({
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.post,
            subRoute: AuthEndpoints.register,
            headers: NetworkConfig.getHeaders(
              needAuth: false,
              type: RequestType.post,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            body: {
              "full_name": fullName,
              "email": email,
              "password": password,
              "password_confirmation": passwordConfirmation,
            },
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(
              response,
            );

            if (commonResponse.getStatus) {
              return Right(TokenInfoModel.fromJson(commonResponse.data['data']));
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

  Future<Either<List<ErrorModel>, ForgotPasswordResponseModel>> forgotPassword({
    required String email,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.post,
            subRoute: AuthEndpoints.forgotPassword,
            headers: NetworkConfig.getHeaders(
              needAuth: false,
              type: RequestType.post,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            body: {"email": email},
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(response);

            if (commonResponse.getStatus) {
              return Right(ForgotPasswordResponseModel.fromJson(commonResponse.data['data']));
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

  Future<Either<List<ErrorModel>, String>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.post,
            subRoute: AuthEndpoints.resetPassword,
            headers: NetworkConfig.getHeaders(
              needAuth: false,
              type: RequestType.post,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            body: {
              "email": email,
              "code": code,
              "new_password": password,
              "new_password_confirmation": passwordConfirmation,
            },
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(response);

            if (commonResponse.getStatus) {
              return Right(commonResponse.data['data']?.toString() ?? '');
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


   
  Future<Either<List<ErrorModel>, TokenInfoModel>> loginWithSocial({
    required String idToken,
  }) async {
    try {
      return _apiService
          .request(
            type: RequestType.post,
            subRoute: AuthEndpoints.loginWithSocial,
            headers: NetworkConfig.getHeaders(
              needAuth: false,
              type: RequestType.post,
              extraHeaders: {"deviceId": "099977932331"},
            ),
            body: {
              "provider": "google",
               "id_token": idToken , 
            },
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(response);

            if (commonResponse.getStatus) {
              return Right(TokenInfoModel.fromJson(commonResponse.data));
            } else {
              return Left(commonResponse.getError);
            }
          });
        
    } catch (e) {
      print(e.toString());
      return Left([ErrorModel(message: e.toString())]);
    }
  }

    
  Future<Either<List<ErrorModel>, ContentLinksResponseModel>> getContentLinks() async {
    try {
      return _apiService
          .request(
            type: RequestType.get, 
            subRoute: AuthEndpoints.contentLinks, 
            headers: NetworkConfig.getHeaders(
              needAuth: false,
              type: RequestType.get,
              extraHeaders: {"deviceId": "099977932331"}, 
            ),
             body: null,
          )
          .then((response) {
            CommonResponse commonResponse = CommonResponse<dynamic>.fromJson(response);

            if (commonResponse.getStatus) {
              return Right(ContentLinksResponseModel.fromJson(commonResponse.data['data'])); 
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

