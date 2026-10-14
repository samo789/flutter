import 'dart:convert';
import 'package:ads_app/core/data/network/network_config.dart';
import 'package:ads_app/core/enums/request_type.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =  NetworkConfig.BASE_URL;

  Future<dynamic> request({
    required RequestType type,
    required String subRoute,
    Map<String, String>? headers,
    Map<String, String>? params,
    Map<String, dynamic>? body,
  }) async {
    Uri url = Uri.https(baseUrl,'api/'+ subRoute, params);
    print(url);
    print(json.encode(body));

    http.Response response;

    switch (type) {
      case RequestType.get:
        response = await http.get(url, headers: headers);

      case RequestType.post:
        response = await http.post(
          url,
          headers: headers,
          body: json.encode(body),
        );

      case RequestType.put:
        response = await http.put(
          url,
          headers: headers,
          body: json.encode(body),
        );

      case RequestType.patch:
        response = await http.patch(
          url,
          headers: headers,
          body: json.encode(body),
        );

      case RequestType.delete:
        response = await http.delete(url, headers: headers);
    }
    

    Map<String, dynamic> jsonResponse = {};
    jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

    jsonResponse.putIfAbsent(
      'response',
      () => {"data": jsonDecode(response.body)},
    );
    print('🔍 RAW RESPONSE BODY: ${response.body}');
    return jsonResponse;
  }
}
