import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class OptionsList extends StatelessWidget {
  String header = "";

  OptionsList(this.header);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: MyText(
          header,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext c, int index) {
        return viewCard(index, c);
      },
    );
  }

  Widget viewCard(int index, BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          viewImage(context),
          title(context),
          subTitle(context),
        ],
      ),
    );
  }

  Widget viewImage(BuildContext context) {
    return
      Stack(children: <Widget>[
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              "assets/images/logo.jpg",
              fit: BoxFit.fill,
            )),
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

  Widget title(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Text(
        "عنوان الموضوع",
        style: TextStyle(
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black),
      ),
    );
  }

  Widget subTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Text(
            "12/7/2020 - 02:30 pm",
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey),
          ),
        ),
        Visibility(
          visible: false,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              "مدة الفيديو  15 دقيقة",
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
}
