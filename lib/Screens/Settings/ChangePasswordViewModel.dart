import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/UserModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Network/BaseApiResponseModel.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

class ChangePasswordViewModel with ChangeNotifier{


  ApiBaseHelper helper=ApiBaseHelper();
  BaseResponse baseResponseModel= new BaseResponse();
  ApiResponse<BaseResponse> baseResponseWraper=ApiResponse.empty("");
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";


  void postData(Map<String,dynamic> data) async{
    baseResponseWraper=ApiResponse.loading("Loading");
    notifyListeners();
    try {
      var response =await helper.get("doChangePassword", data);
      var parsedResponse=json.decode(response.data);
      baseResponseModel=BaseResponse.fromJson(parsedResponse);

      if(baseResponseModel.status=="01"){
        baseResponseWraper=ApiResponse.completed(baseResponseModel);
        notifyListeners();
      }
      else{
        baseResponseWraper=ApiResponse.error(error);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      baseResponseWraper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}