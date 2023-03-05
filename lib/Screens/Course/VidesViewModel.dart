import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Models/VideosModel.dart';
import 'package:tawjihi/Network/ApiBaseHelper.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';

class VideosViewModel with ChangeNotifier{

  ApiResponse<VideosModel> videosWrapper=ApiResponse.empty("");
  ApiBaseHelper helper=ApiBaseHelper();
  VideosModel videos= new VideosModel();
  String error="حدث خطأ ما تحقق منن الانترنت وحاول مره أخري";

  void get(Map<String,dynamic> data) async{
    videosWrapper=ApiResponse.loading("Loading");
    notifyListeners();
    try {

      var response =await helper.get("getAllMaterialVideoes",data);
      var parsedResponse=json.decode(response.data);
      videos=VideosModel.fromJson(parsedResponse);
      if(videos.status=="01"){
        videosWrapper=ApiResponse.completed(videos);
        notifyListeners();

      }
      else if(videos.status=="05"){
        videosWrapper=ApiResponse.error(videos.message);
        error="انت غيرمفعل لاستخدام التطبيق";
        notifyListeners();
      }
      else{
        videosWrapper=ApiResponse.error(videos.message);
        notifyListeners();
      }
    }
    on Exception catch (e) {
      print("here"+"error"+e.toString());
      videosWrapper=ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}