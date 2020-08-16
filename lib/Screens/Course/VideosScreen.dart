import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Models/VideosModel.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/VideoPlayer.dart';
import 'package:tawjihi/Screens/Course/VidesViewModel.dart';
import 'package:tawjihi/Screens/Course/WebViewListViewModel.dart';
import 'package:tawjihi/Screens/Course/WebView.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';

import '../BaseScreen.dart';

class Videos extends StatefulWidget {
  String header = "";
  String courseName = "";
  int materialId;
  int type;

  Videos(this.header,this.courseName,this.materialId,this.type);

  @override
  _VideosState createState() => _VideosState(header,courseName,materialId,type);
}

class _VideosState extends State<Videos> with BaseScreen {
  String header;
  String courseName;
  int materialId;
  int type;

  _VideosState(this.header,this.courseName,this.materialId,this.type);

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getData(materialId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: MyText(
          widget.header,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        Consumer<VideosViewModel>(
            builder: (context, model, child){
              return  switchWidgets(model,context);
            })

      ],
    );

  }

  Widget viewCard(int index, BuildContext context,VideosModel data) {
    return GestureDetector(
      onTap: (){
        //play video
        Navigator.of(context).push(MaterialPageRoute(builder:(_)=> VideoApp(data.details[index].video)));
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            viewImage(context,data,index),
            title(context,data,index),
            subTitle(context,data,index),
          ],
        ),
      ),
    );
  }

  Widget viewImage(BuildContext context,VideosModel dataList,int index) {
    return
      Stack(children: <Widget>[
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image.asset("assets/images/logo.jpg",fit: BoxFit.cover,),
        ),
        Visibility(
          visible: true,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Icon(Icons.play_circle_filled,color: Colors.white,size: 24,),
              )),
        )
      ],);
  }

  Widget title(BuildContext context,VideosModel dataList,int index) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Text(
        dataList.details[index].title,
        style: TextStyle(
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black),
      ),
    );
  }

  Widget subTitle(BuildContext context,VideosModel dataList,int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Text(
            dataList.details[index].created_at,
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey),
          ),
        ),
        Visibility(
          visible: true,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              dataList.details[index].updated_at,
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget switchWidgets(VideosViewModel model,BuildContext context) {
    switch (model.videosWrapper.status){
      case Status.LOADING:
        return super.loadingIndicator(model.videosWrapper.status==Status.LOADING, context);
        break;
      case Status.empty:
        return super.loadingIndicator(model.videosWrapper.status==Status.empty, context);

      case Status.ERROR:
        return
          Visibility(
            visible: model.videosWrapper.status==Status.ERROR,
            child:Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(model.error,
                  style:
                  TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
          );
        break;
      case Status.COMPLETED:
        return
          ListView.builder(
            itemCount: model.videos.details.length,
            itemBuilder: (BuildContext context, int index) {
              return viewCard(index, context,model.videos);
            },
          );
        break;
    }
  }

  void getData(int materialId) {
    Map<String,dynamic> paramaters=new Map();
    paramaters.putIfAbsent("materialId", () =>materialId);
    Provider.of<VideosViewModel>(context,listen: false).get(paramaters);
  }
}
