import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/BaseModel.dart';
import 'package:tawjihi/Models/UserModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

class ForgetPasswordViewModel with ChangeNotifier{


  ApiBaseHelper helper=ApiBaseHelper();
  BaseModel model= new BaseModel();
  ApiResponse<BaseModel> resposeWrapper=ApiResponse.empty("");
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";


  void postData(Map<String,dynamic> data) async{
    resposeWrapper=ApiResponse.loading("Loading");
    notifyListeners();
    try {
      var response =await helper.post("forgot_password", data);
      var parsedResponse=json.decode(response.data);
      model=BaseModel.fromJson(parsedResponse);
      if(model.status=="01"){
        resposeWrapper=ApiResponse.completed(model);
        notifyListeners();

      }
      else{
        resposeWrapper=ApiResponse.error(model.message);
        error=model.message;
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      resposeWrapper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}