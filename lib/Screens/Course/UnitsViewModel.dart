import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Models/UnitsModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';

class UnitsViewModel with ChangeNotifier{

  ApiResponse<UnitsModel> unitsResponseWraper=ApiResponse.empty("");
  ApiBaseHelper helper=ApiBaseHelper();
  UnitsModel units= new UnitsModel();

  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";

  void get(Map<String,dynamic> data) async{
    unitsResponseWraper=ApiResponse.loading("Loading");
    notifyListeners();
    try {

      var response =await helper.get("getAllMaterialUnits",data);
      var parsedResponse=json.decode(response.data);
      units=UnitsModel.fromJson(parsedResponse);
      if(units.status=="01"){
        unitsResponseWraper=ApiResponse.completed(units);
        notifyListeners();

      }
      else if(units.status=="05"){
        unitsResponseWraper=ApiResponse.error(units.message);
        error="انت غيرمفعل لاستخدام التطبيق";
        notifyListeners();

      }
      else{
        unitsResponseWraper=ApiResponse.error(units.message);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      unitsResponseWraper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}