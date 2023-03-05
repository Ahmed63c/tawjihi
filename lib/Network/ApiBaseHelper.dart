import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:tawjihi/Network/ApiClient.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'BaseApiResponseModel.dart';
import 'CustomAppExpection.dart';
import 'dart:convert';


class ApiBaseHelper {


  Future<dynamic> get(String url,Map<String,dynamic>parameters) async {
    var responseJson;
    try {
      final response = await DioProvider.instance().get(
          Constant.BASE_URL + url,queryParameters:parameters);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Response> post(String url,Map<String,dynamic>parameters) async {
    var responseJson;
    try {
      final response = await DioProvider.instance().post(
          Constant.BASE_URL + url,queryParameters:parameters);
      print("res"+response.toString());
          responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Response> postForm(String url,FormData formData) async {
    var responseJson;
    try {
      var webService=DioProvider.instance();
      webService.options.contentType="multipart/form-data";
      final response = await webService.post(
          Constant.BASE_URL + url,data:formData);
      print("res"+response.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  Response _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
        break;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:throw FetchDataException('Error occured while Communication with Server with StatusCode :'
            ' ${response.statusCode}');
    }
  }

}
