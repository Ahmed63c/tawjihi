import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tawjihi/Models/QAndAnswersModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
class QuestionsAndAnswersViewModel with ChangeNotifier{

  ApiResponse<QAndAnswersModel> QAndAnswersResponseWraper=ApiResponse.empty("");
  ApiBaseHelper helper=ApiBaseHelper();
  QAndAnswersModel QAndAnswers= new QAndAnswersModel();

  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";

  void get(Map<String,dynamic> data) async{
    QAndAnswersResponseWraper=ApiResponse.loading("Loading");
    notifyListeners();
    try {

      var response =await helper.get("getMaterialQuestions",data);
      var parsedResponse=json.decode(response.data);
      QAndAnswers=QAndAnswersModel.fromJson(parsedResponse);
      if(QAndAnswers.status=="01"){
        QAndAnswersResponseWraper=ApiResponse.completed(QAndAnswers);
        notifyListeners();

      }
      else{
        QAndAnswersResponseWraper=ApiResponse.error(QAndAnswers.message);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      QAndAnswersResponseWraper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}