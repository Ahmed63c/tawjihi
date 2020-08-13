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
      connectTimeout: 60*1000, // 60 seconds
      receiveTimeout: 60*1000,
      followRedirects: true,
    );
    dio.interceptors.add(HttpLogInterceptor());
    return dio;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    log("onRequest: ${options.uri}\n"
        "data=${options.data}\n"
        "method=${options.method}\n"
        "headers=${options.headers}\n"
        "queryParameters=${options.queryParameters}");
        StorageUtil.getInstance().then((storage){
            String token= StorageUtil.getString(Constant.TOKEN);
            options.headers["Authorization"] = "Bearer " + token;
                         });

    return options;
  }

  @override
  Future onResponse(Response response) {
    log("onResponse: $response");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    log("onError: $err\n"
        "Response: ${err.response}");
    return super.onError(err);
  }
}