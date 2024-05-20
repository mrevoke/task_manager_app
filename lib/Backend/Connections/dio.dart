import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../Essentials_App/prefs.dart';
import '../../Essentials_App/consts.dart';
import '../../Essentials_App/depndency_injection.dart';
import 'dio_intercptr.dart';

const String APPLICATION_JSON = 'application/json';
const String MULTIPART_JSON = 'multipart/form-data';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'lang';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration timeOut = const Duration(seconds: 60);
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: 'Bearer ${await _appPreferences.getUserToken()}',
      DEFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );
    dio.interceptors.add(instance<GeneralInterceptor>());

    if (kReleaseMode) {
      if (kDebugMode) {
        print('release mode no logs');
      }
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
        request: true,
        responseBody: true,
      ));
    }
    return dio;
  }
}
