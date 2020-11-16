import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/BaseModel.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Models/TestModel.dart';
import 'package:tawjihi/Models/UnitsModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';

class NumberOfTestsViewModel with ChangeNotifier{

  ApiResponse<BaseModel> wrapper=ApiResponse.empty("");
  ApiBaseHelper helper=ApiBaseHelper();
  BaseModel model= new BaseModel();

  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";

  void get(Map<String,dynamic> data) async{
    wrapper=ApiResponse.loading("Loading");
    notifyListeners();
    try {

      var response =await helper.get("getMaterialMultipleChoiceQuizCount",data);
      var parsedResponse=json.decode(response.data);
      model=BaseModel.fromJson(parsedResponse);
      if(model.status=="01"){
        wrapper=ApiResponse.completed(model);
        notifyListeners();

      }
      else{
        wrapper=ApiResponse.error(model.message);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      wrapper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}