import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/UserModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

class LoginViewModel with ChangeNotifier{


 ApiBaseHelper helper=ApiBaseHelper();
UserModel userModel= new UserModel();
ApiResponse<UserModel> user=ApiResponse.empty("");
String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";


void postData(Map<String,dynamic> data) async{
  user=ApiResponse.loading("Loading");
  notifyListeners();
  try {
    var response =await helper.post("login", data);
    var parsedResponse=json.decode(response.data);
    userModel=UserModel.fromJson(parsedResponse);
    if(userModel.status=="01"){

      if(userModel.details.appVersion==Constant.APP_VERSION){
        StorageUtil.getInstance().then((storage){
          StorageUtil.putBool(Constant.LOGGED_IN,true);
          StorageUtil.putString(Constant.TOKEN, userModel.details.access_token);
          StorageUtil.putString(Constant.MAJOR, userModel.details.user.major);
          StorageUtil.putString(Constant.PHONE, userModel.details.configuration[0].value);
          StorageUtil.putString(Constant.WHATS, userModel.details.configuration[1].value);
          StorageUtil.putString(Constant.ABOUT, userModel.details.configuration[2].value);
          StorageUtil.putString(Constant.GET_CODE, userModel.details.configuration[3].value);
          StorageUtil.putString(Constant.FACE_BOOK, userModel.details.configuration[4].value);
          StorageUtil.putString(Constant.YOUTUBE, userModel.details.configuration[5].value);
          StorageUtil.putString(Constant.TWITTER, userModel.details.configuration[6].value);
          StorageUtil.putString(Constant.LINKED_IN, userModel.details.configuration[7].value);
          StorageUtil.putString(Constant.INSTGRAM, userModel.details.configuration[8].value);
          StorageUtil.putString(Constant.EMAIL, userModel.details.configuration[9].value);
        });
        user=ApiResponse.completed(userModel);
        notifyListeners();
      }


      else{
        error="تم تحديث نسخه التطبيق من فضلك حمل النسخة الجديدة";
        user=ApiResponse.error(error);
        notifyListeners();
      }



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
    notifyListeners();
  }
}
}