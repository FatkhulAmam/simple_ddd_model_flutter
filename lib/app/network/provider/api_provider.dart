import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/env.dart';
import '../../../utility/log/dio_logger.dart';
import '../../../utility/shared/constants/constants.dart';

class APIProvider {
  static const String TAG = 'APIProvider';
  static final String _baseUrl = Env.value.baseUrl + '/api';

  late bool isConnected = false;
  late Dio _dio;
  var tokenDio = Dio();
  late BaseOptions dioOptions;
  var storage = Get.find<SharedPreferences>();

  APIProvider() {
    dioOptions = BaseOptions()..baseUrl = APIProvider._baseUrl;
    dioOptions.validateStatus = (value) {
      return value! < 500;
    };

    _dio = Dio(dioOptions);
    tokenDio.options = _dio.options;

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      DioLogger.onSend(TAG, options);
      await checkConnectivity();
      return handler.next(options);
    }, onResponse: (response, handler) {
      DioLogger.onSuccess(TAG, response);
      return handler.next(response);
    }, onError: (DioError dioError, handler) {
      DioLogger.onError(TAG, dioError);

      throwIfNoSuccess(dioError);
      return handler.next(dioError);
    }));

    // if you use ip dns server
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate=(client){
      client.badCertificateCallback=(X509Certificate cert, String host, int port){
        return true;
      };
    };
  }


  Future<Response> postData(String path, dynamic data) async {
    try {
      var response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> postToken(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> postFile(String path, FormData data) async {
    try {
      var response = await _dio.post(
        path,
        data: data,
        onSendProgress: (int sent, int total) {
          Get.log("Uploading ${(sent / total * 100)}%");
          /*Get.dialog(
              LiquidLinearProgressIndicator(
                value: sent/total *100, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.red,
                borderWidth: 5.0,
                borderRadius: 12.0,
                direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                center: Text("Uploading ${(sent/total * 100)}%"),
              ),
          );
          Get.back();*/
        },
      );
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> getData(String path) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> deleteData(String path) async {
    try {
      var response = await _dio.delete(path);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> deleteDataWithParams(String path, dynamic data) async {
    try {
      var response = await _dio.delete(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> dasboardInformation(String path) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> authSocial(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> getDataWithParams(
      String path, Map<String, dynamic> params) async {
    try {
      var response = await _dio.get(path, queryParameters: params);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> putData(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.put(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  void throwIfNoSuccess(DioError ex) async {
    if (ex.response!.statusCode! < 200 || ex.response!.statusCode! > 299) {
      Get.log("Gagal Oy");
      String errorMessage = json.decode(ex.response.toString())["error"] ??
          json.decode(ex.response.toString())["message"];
      Get.snackbar(
        'Oops..',
        errorMessage,
        backgroundColor: const Color(0xFF3F4E61),
      );
      throw  Exception(errorMessage);
    }
  }

  Future<BaseOptions> addAuthorOpt() async {
    dioOptions.headers = {
      'X-Auth-token': '${storage.getString(StorageConstants.token)}',
      'X-User-token': '${storage.getString(StorageConstants.token)}',
      'X-User-id': '${storage.getString(StorageConstants.userId)}',
    };

    Get.log('header : ${dioOptions.headers}');
    return dioOptions;
  }

  Future<BaseOptions> urlCustomOpt(String url) async {
    dioOptions.baseUrl = url;
    return dioOptions;
  }

  Future<BaseOptions> urlDefaultOpt() async {
    dioOptions.baseUrl = _baseUrl;
    return dioOptions;
  }

  Future<Response> customGetData(
      {required String domain,
      required String path,
      Map<String, dynamic>? params}) async {
    try {
      await urlCustomOpt(domain);
      // final _dioExternal = Dio();
      var response = await _dio.get(path, queryParameters: params);
      await urlDefaultOpt();
      return response;
    } on DioError catch (ex) {
      // urlDefaultOpt();
      throw  Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  noInternetWarning() async {
    await Get.defaultDialog(
      title: "No Internet",
      titlePadding: const EdgeInsets.all(20),
      titleStyle: const TextStyle(fontSize: 14),
      contentPadding: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
      middleText: "Please check your connectivity!",
      middleTextStyle: const TextStyle(
        fontSize: 10,
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text("Try Again"),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text("Close"),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.back();
      isConnected = false;
      noInternetWarning();
    } else {
      isConnected = true;
    }
  }

  Future<Response> postMedia(String path, dynamic data, {required String titleProgress}) async {
    try {
      var response = await _dio.post(
        path,
        data: data,
        onSendProgress: (int sent, int total) {
          Get.log("Uploading ${(sent / total * 100)}%");
          var percentage = sent/total*100;
          if( percentage < 98) {
            Get.log("${percentage/100}, status: $titleProgress... ${percentage.toInt()}");
          }
        },
        onReceiveProgress: (count, total) {
          Get.log("${100/100}, status: '$titleProgress... ${100}%");
        }

      );
      return response;
    } on DioError catch (ex) {
      throw new Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> post(String path) async {
    try {
      var response = await _dio.post(path);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }
}
