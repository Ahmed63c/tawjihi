import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Models/TestModel.dart';
import 'package:tawjihi/Models/UnitsModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';

class TestViewModel with ChangeNotifier{

  ApiResponse<TestModel> testResponseWraper=ApiResponse.empty("");
  ApiBaseHelper helper=ApiBaseHelper();
  TestModel test= new TestModel();

  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";

  void get(Map<String,dynamic> data) async{
    testResponseWraper=ApiResponse.loading("Loading");
    notifyListeners();
    try {

      var response =await helper.get("getMaterialMultipleChoiceQuiz",data);
      var parsedResponse=json.decode(response.data);
      test=TestModel.fromJson(parsedResponse);
      if(test.status=="01"){
        testResponseWraper=ApiResponse.completed(test);
        notifyListeners();

      }
      else{
        testResponseWraper=ApiResponse.error(test.message);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      testResponseWraper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}