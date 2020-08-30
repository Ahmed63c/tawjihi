import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/UserModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

class SignUpViewModel with ChangeNotifier{


  ApiBaseHelper helper=ApiBaseHelper();
  UserModel userModel= new UserModel();
  ApiResponse<UserModel> user=ApiResponse.empty("");
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";


  void postData(FormData formData) async{
    user=ApiResponse.loading("Loading");
    notifyListeners();
    try {
      var response =await helper.postForm("signup", formData);
      var parsedResponse=json.decode(response.data);
      userModel=UserModel.fromJson(parsedResponse);
      if(userModel.status=="01"){
        user=ApiResponse.completed(userModel);
        StorageUtil.getInstance().then((storage){
          StorageUtil.putString(Constant.TOKEN, userModel.details.access_token);
          StorageUtil.putString(Constant.MAJOR, userModel.details.user.major);
        });
        notifyListeners();
      }
      else{
        user=ApiResponse.error(userModel.message);
        error=userModel.message;
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      user=ApiResponse.error(e.toString());
      error=e.toString();
      notifyListeners();
    }
  }
}