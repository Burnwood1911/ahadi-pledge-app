// ignore_for_file: avoid_print

import 'package:ahadi_pledge/constants/constants.dart';
import 'package:ahadi_pledge/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as getx;

class DioClient {
// dio instance
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = 15000
      ..options.receiveTimeout = 15000
      ..options.responseType = ResponseType.json
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            requestInterceptor(options, handler),
        onResponse: (Response response, handler) =>
            responseInterceptor(response, handler),
        onError: (e, handler) => errorInterceptor(e, handler),
      ));
  }

  dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(
        {"Accept": "application/json", "Content-Type": "application/json"});
    if (options.headers.containsKey("requiresToken")) {
      options.headers.remove("requiresToken");
    } else {
      options.headers
          .addAll({"Authorization": "Bearer ${GetStorage().read("token")}"});
    }
    String headers = "";
    options.headers.forEach((key, value) {
      headers += "| $key: $value";
    });

    print(
        "┌------------------------------------------------------------------------------");
    print('''| [DIO] Request: ${options.method} ${options.uri}
    | ${options.data.toString()}
    | Headers:\n$headers''');
    print(
        "├------------------------------------------------------------------------------");

    handler.next(options);
  }

  dynamic errorInterceptor(
      DioError dioError, ErrorInterceptorHandler handler) async {
    print("| [DIO] Error: ${dioError.error}: ${dioError.response.toString()}");
    print(
        "└------------------------------------------------------------------------------");
    if (dioError.response?.statusCode == 401) {
      if (getx.Get.currentRoute != "/AuthScreen") {
        getx.Get.offAll(() => AuthScreen());
        getx.Get.showSnackbar(const getx.GetSnackBar(
          title: "Session Expired",
          message: "Your login session has expired please login again",
          duration: Duration(seconds: 2),
        ));

        await GetStorage().remove("token");
      }
      return dioError;
    } else {
      handler.next(dioError);
    }
  }

  dynamic responseInterceptor(
      Response response, ResponseInterceptorHandler handler) async {
    print(
        "| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
    print(
        "└------------------------------------------------------------------------------");
    handler.next(response);
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
