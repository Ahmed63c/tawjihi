import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

class DioProvider {
  static Dio instance() {
    final dio = Dio();
    dio.options=new BaseOptions(
      baseUrl:Constant.BASE_URL,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60), // 60 seconds
      receiveTimeout: Duration(seconds: 60),
      followRedirects: true,
    );
    dio.interceptors.add(HttpLogInterceptor());
    return dio;
  }
}

class HttpLogInterceptor extends Interceptor {

  // @override
  // void onRequest(RequestOptions options,RequestInterceptorHandler handler))  {
  //   log("onRequest: ${options.uri}\n"
  //       "data=${options.data}\n"
  //       "method=${options.method}\n"
  //       "headers=${options.headers}\n"
  //       "queryParameters=${options.queryParameters}");
  //       StorageUtil.getInstance().then((storage){
  //           String token= StorageUtil.getString(Constant.TOKEN);
  //           options.headers["Authorization"] = "Bearer " + token;
  //                        });
  //
  //   return options;
  // }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}