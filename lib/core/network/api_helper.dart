import 'dart:developer';

import 'package:dio/dio.dart';

import '../cache/cache_helper.dart';
import '../cache/cache_keys.dart';
import 'api_response.dart';
import 'end_points.dart';

class APIHelper {
  // declaring dio
  static final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  static Future init() async {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          log("--- Headers : ${options.headers.toString()}");
          log("--- endpoint : ${options.path.toString()}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("--- Response : ${response.data.toString()}");
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          log("--- Error : ${error.response?.data.toString()}");
          var errorResponse = error.response?.data as Map<String, dynamic>;
          try {
            if (errorResponse['message']
                .toString()
                .contains('Token has expired.')) {
              var result = await _dio.post(EndPoints.refreshToken,
                  options: Options(headers: {
                    'Authorization':
                    'Bearer ${await CacheHelper.getValue(
                        CacheKeys.refreshToken)}'
                  }));
              var accessData = result.data as Map<String, dynamic>;
              await CacheHelper.setValue(
                  CacheKeys.accessToken, accessData['access_token']);

              // Retry original request
              final options = error.requestOptions;
              if (options.data is FormData) {
                final oldFormData = options.data as FormData;

                // Convert FormData to map so it can be rebuilt
                final Map<String, dynamic> formMap = {};
                for (var entry in oldFormData.fields) {
                  formMap[entry.key] = entry.value;
                }

                // Add files if any
                for (var file in oldFormData.files) {
                  formMap[file.key] = file.value;
                }

                // Rebuild new FormData
                options.data = FormData.fromMap(formMap);
              }
              options.headers['Authorization'] =
              'Bearer ${await CacheHelper.getValue(CacheKeys.accessToken)}';
              final response = await _dio.fetch(options);
              return handler.resolve(response);
            }
          } catch (e) {

          }

          return handler.next(error);
        })
    );
  }

  // get request

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await _dio.get(
          endPoint, queryParameters: queryParams, options: Options(
          headers: {
            if(isAuthorized)'Authorization':
            'Bearer ${await CacheHelper.getValue(CacheKeys.accessToken)}'
          }
      ));
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  // post

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await _dio.post(
          endPoint,
          data: data == null
              ? null
              : isFormData
              ? FormData.fromMap(data)
              : data,
          options: Options(
              headers: {
                if(isAuthorized)'Authorization':
                'Bearer ${await CacheHelper.getValue(CacheKeys.accessToken)}'
              }
          )
          );
          return ApiResponse.fromResponse(response);
    } catch (e) {
      // ignore: avoid_print
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await _dio.put(
          endPoint,
          data: data == null
              ? null
              : isFormData
              ? FormData.fromMap(data)
              : data,
          options: Options(
              headers: {
                if(isAuthorized)'Authorization':
                'Bearer ${await CacheHelper.getValue(CacheKeys.accessToken)}'
              }
          ));
          return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await _dio.delete(
          endPoint,
          data: data == null
              ? null
              : isFormData
              ? FormData.fromMap(data)
              : data,
          options: Options(
              headers: {
                if(isAuthorized)'Authorization':
                'Bearer ${await CacheHelper.getValue(CacheKeys.accessToken)}'
              }
          ));
          return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}