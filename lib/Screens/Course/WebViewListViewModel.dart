import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';

class WebViewListViewModel with ChangeNotifier{

  ApiResponse<DataList> materials=ApiResponse.empty("");
  ApiBaseHelper helper=ApiBaseHelper();
  DataList materialList= new DataList();
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";

  void get(Map<String,dynamic> data) async{
    materials=ApiResponse.loading("Loading");
    notifyListeners();
    try {

      var response =await helper.get("getAllMaterialArticles",data);
      var parsedResponse=json.decode(response.data);
      materialList=DataList.fromJson(parsedResponse);
      if(materialList.status=="01"){

        materials=ApiResponse.completed(materialList);
        notifyListeners();

      }
      else{
        materials=ApiResponse.error(materialList.message);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      materials=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}