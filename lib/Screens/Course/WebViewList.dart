import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Models/DataList.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/WebViewListViewModel.dart';
import 'package:tawjihi/Screens/Course/WebView.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';

import '../BaseScreen.dart';

class WebViewList extends StatefulWidget {
  String header = "";
  String courseName = "";
  int materialId;
  int type;

  WebViewList(this.header,this.courseName,this.materialId,this.type);

  @override
  _WebViewListState createState() => _WebViewListState(header,courseName,materialId,type);
}

class _WebViewListState extends State<WebViewList> with BaseScreen {
  String header;
  String courseName;
  int materialId;
  int type;

  _WebViewListState(this.header,this.courseName,this.materialId,this.type);

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
    getData(materialId,type);
    return Stack(
      children: <Widget>[
        Consumer<WebViewListViewModel>(
            builder: (context, model, child){
              return  switchWidgets(model,context);
            })

      ],
    );

  }

  Widget viewCard(int index, BuildContext context,DataList data) {
    return Directionality(
      textDirection:materialId==2?TextDirection.ltr:TextDirection.rtl,

      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(_)=> WebViewPage(data.details[index].description)));
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
      ),
    );
  }

  Widget viewImage(BuildContext context,DataList dataList,int index) {
    return
      Stack(children: <Widget>[
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
//            child: Image(image: CachedNetworkImageProvider(dataList.details[index].pics==null
//                ? "" : dataList.details[index].pics),),
        child: Image.asset("assets/images/logo.jpg",fit: BoxFit.cover,),
        ),
        Visibility(
          visible: false,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Icon(Icons.play_circle_filled,color: Colors.white,size: 24,),
              )),
        )
      ],);
  }

  Widget title(BuildContext context,DataList dataList,int index) {
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

  Widget subTitle(BuildContext context,DataList dataList,int index) {
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
      ],
    );
  }

  Widget switchWidgets(WebViewListViewModel model,BuildContext context) {
    switch (model.materials.status){
      case Status.LOADING:
        return super.loadingIndicator(model.materials.status==Status.LOADING, context);
            break;
      case Status.empty:
        return super.loadingIndicator(model.materials.status==Status.empty, context);

      case Status.ERROR:
        return
          Visibility(
                  visible: model.materials.status==Status.ERROR,
                  child:Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(model.error,
                          style:
                          TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),),
                      )),
                );
        break;
      case Status.COMPLETED:
    return
      model.materialList.details.length>0?
      ListView.builder(
        itemCount: model.materialList.details.length,
        itemBuilder: (BuildContext context, int index) {
          return viewCard(index, context,model.materialList);
        },
      ):Container(
        child: Center(
          child: MyText("error_empty",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w700
          ,fontSize: 18),),
        ),
      );
    break;
    }
  }

  void getData(int materialId,int type) {
    Map<String,dynamic> paramaters=new Map();
    paramaters.putIfAbsent("materialId", () =>materialId);
    paramaters.putIfAbsent("type", () => type);
    Provider.of<WebViewListViewModel>(context,listen: false).get(paramaters);
  }
}
