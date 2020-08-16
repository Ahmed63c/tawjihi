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
      StorageUtil.getInstance().then((storage){
        StorageUtil.putString(Constant.TOKEN, userModel.details.access_token);
        StorageUtil.putString(Constant.MAJOR, userModel.details.user.major);
        StorageUtil.putBool(Constant.LOGGED_IN,true);
      });
      user=ApiResponse.completed(userModel);
      notifyListeners();

    }
    else{
      user=ApiResponse.error(userModel.message);
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