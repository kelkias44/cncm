import 'package:cncm_flutter_new/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/ErrorResponse.dart';
import '../util/local_storage_service.dart';

class ApiBaseHelper {
  static const String url = 'https://api.a2p.et:5666/cmo/api/v1';

  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest:
                (RequestOptions options, RequestInterceptorHandler handler) =>
                handler.next(requestInterceptor(options)),
            onError: (DioError e, ErrorInterceptorHandler handler) async {
              ///DioLogger.onError(TAG, error);
              return handler.next(e.response!.data);
            }),
      );
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    String token = sl<LocalStorageService>().getToken;
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static final dio = createDio();

  static final baseAPI = addInterceptors(dio);

  ///get the allowed in case we develop
  Future<Response> getHTTP(String url) async {
    try {
      Response response = await dio.get(url);
      return response;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Response> postHTTP(String url, dynamic data) async {
    try {
      Response response = await dio.post(url, data: data);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> putHTTP(String url, dynamic data) async {
    try {
      Response response = await dio.put(url, data: data);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> deleteHTTP(String url) async {
    try {
      Response response = await dio.delete(url);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

// // Multiple Files with Additional Data
// FormData formData = FormData.fromMap({
//
//   "files": [
//     await MultipartFile.fromFile("PATH", filename: "OPTIONAL"),
//     MultipartFile.fromFileSync("PATH", filename: "OPTIONAL")
//   ],
// });
}
