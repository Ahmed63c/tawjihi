import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';
import 'package:tawjihi/Screens/Course/VideosScreen.dart';
import 'package:tawjihi/Screens/Course/VidesViewModel.dart';
import 'package:tawjihi/Screens/Course/WebViewList.dart';
import 'package:tawjihi/Screens/Course/WebViewListViewModel.dart';
import 'package:tawjihi/Screens/Settings/SettingsScreen.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';
import 'package:url_launcher/url_launcher.dart';

class GuidenessScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: Text(
            AppLocalizations.of(context).translate("guidance"),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: "Cairo"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
            )
          ],
        ),
        body:guideMaterials(context) ,
        floatingActionButton: speedDial(context)
    );
  }

  Widget guideMaterials(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return
      ListView(
        shrinkWrap: true,
        children: [
          GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: itemWidth / itemHeight,
            children: <Widget>[
              tile(context, "videos", Constant.GUIDENESS,Image.asset(
                'assets/images/videos.png',
                fit: BoxFit.fill,
              ),),
              tile(context, "school_order",Constant.SCHOOL_ORDER,Image.asset(
                'assets/images/examOrder.png',
                fit: BoxFit.fill,
              ),),
              tile(context, "exam_worry", Constant.EXAM_WORRY,Image.asset(
                'assets/images/examWorry.png',
                fit: BoxFit.fill,
              ),),
              tile(context, "problems", Constant.PROBLEMS,Image.asset(
                'assets/images/problems.png',
                fit: BoxFit.fill,
              ),),
              tile(context, "skills", Constant.SKILLS,Image.asset(
                'assets/images/skills.png',
                fit: BoxFit.fill,
              ),),
            ],
          ),
          Divider(height: 100,)
        ],
      );
  }


  Widget speedDial(BuildContext context) {
    return SpeedDial(
      marginRight: 32,
      marginBottom: 32,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.0,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.blue,
      foregroundColor: Colors.black,
      elevation: 8.0,
      animatedIcon: AnimatedIcons.home_menu,
      animatedIconTheme: IconThemeData(color: Colors.white),
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.mail),
            backgroundColor: Colors.red,
            onTap: ()
            {
              StorageUtil.getInstance().then((storage){
                String email=StorageUtil.getString(Constant.EMAIL);
                _launchURL(email);
              });}
        ),
        SpeedDialChild(
            child: Icon(Icons.call,color: Colors.white,),
            backgroundColor: Colors.green,
            onTap: () {
              StorageUtil.getInstance().then((storage){
                String phone=StorageUtil.getString(Constant.PHONE);
                launchWhatsApp(phone: phone, message: "مرحبا");
              });}
        ),
      ],
    );
  }


  Widget tile(BuildContext context, String courseName,int materialId, Image image) {
    return Container(
      child: GestureDetector(
        onTap: () {
          switch(materialId){
            case Constant.GUIDENESS:
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>VideosViewModel(),
                    child: Videos("videos",courseName,Constant.GUIDENESS,0),
                  )
              )
              );
              break;
            case Constant.SCHOOL_ORDER:
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>WebViewListViewModel(),
                    child: WebViewList("articles",courseName,Constant.GUIDENESS,Constant.SCHOOL_ORDER),
                  )
              ));

              break;
            case Constant.EXAM_WORRY:
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>WebViewListViewModel(),
                    child: WebViewList("articles",courseName,Constant.GUIDENESS,Constant.EXAM_WORRY),
                  )
              ));
            break;
            case Constant.PROBLEMS:
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>WebViewListViewModel(),
                    child: WebViewList("articles",courseName,Constant.GUIDENESS,Constant.PROBLEMS),
                  )
              ));
            break;
            case Constant.SKILLS:
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>WebViewListViewModel(),
                    child: WebViewList("articles",courseName,Constant.GUIDENESS,Constant.SKILLS),
                  )
              ));
            break;

          }
        },
        child:
        Stack(children: <Widget>[
          Container(
              height: double.infinity,
              child: image),
          Positioned(
            bottom: 30,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120,
                  margin: EdgeInsets.only(bottom: 4, right: 8, left: 8),
                  child: MyText(courseName,
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: MyText(
                        "explore",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Cairo"),
                      )),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
  void _launchURL(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print( 'Could not launch $url');
    }
  }
}