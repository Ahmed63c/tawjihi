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

class Home extends StatelessWidget {
  bool isLitery=false;
  Home(this.isLitery);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child:
      Scaffold(
          appBar: AppBar(
            backgroundColor: ColorProperties.AppColor,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context).translate("home"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Cairo"),
            ),
            bottom: tabBar(context),
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
          body: TabBarView(
            children: <Widget>[
              isLitery?homeAdby(context):home(context),
              secondTab(context),
              thirdTab(context)
            ],
          ),
          floatingActionButton: speedDial()
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.blueAccent,
      labelColor: Colors.white,
      isScrollable: true,
      labelPadding: EdgeInsets.only(right: 14, left: 14),
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(
          child: Text(AppLocalizations.of(context).translate("main"),
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
        ),
        Tab(
          child: Text(AppLocalizations.of(context).translate("common"),
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
        ),
        Tab(
          child: Text(AppLocalizations.of(context).translate("guidance"),
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget home(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return
      GridView.count(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / itemHeight,
        children: <Widget>[
          tile(context, "math",Constant.MATH_ID, Image.asset(
            'assets/images/math.png',
            fit: BoxFit.fill,
          ),),
          tile(context, "biology", Constant.BIOLOGY_ID,Image.asset(
            'assets/images/biology.png',
            fit: BoxFit.fill,
          ),),
          tile(context, "chemistry", Constant.CHEMISTRY_ID,Image.asset(
            'assets/images/chemistry.png',
            fit: BoxFit.fill,
          ),),
          tile(context, "physics",Constant.PHYSICS_ID, Image.asset(
            'assets/images/physics.png',
            fit: BoxFit.fill,
          ),),
        ],
      );
  }

  Widget homeAdby(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: itemWidth / itemHeight,
      children: <Widget>[
        tile(context, "math",Constant.MATH_ID, Image.asset(
          'assets/images/math.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "sci",Constant.SCIENTIFIC_CALTURE_ID, Image.asset(
          'assets/images/scientific_culture.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "history", Constant.HISTORY_ID,Image.asset(
          'assets/images/history.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "geo", Constant.GEOGRAPHIC_ID,Image.asset(
          'assets/images/geography.png',
          fit: BoxFit.fill,
        ),),
      ],
    );
  }

  Widget secondTab(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: itemWidth / itemHeight,
      children: <Widget>[
        tile(context, "english",Constant.ENGLISH_ID,Image.asset(
          'assets/images/english.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "arabic",Constant.ARABIC_ID,Image.asset(
          'assets/images/arabic.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "islamic", Constant.ISLAMIC_ID,Image.asset(
          'assets/images/islamic.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "tech", Constant.TECH_ID,Image.asset(
          'assets/images/technology.png',
          fit: BoxFit.fill,
        ),),
      ],
    );
  }

  Widget thirdTab(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: itemWidth / itemHeight,
      children: <Widget>[
        tile(context, "articles", Constant.GENRAL_VIDEOS_ARTICLES,Image.asset(
          'assets/images/articles.png',
          fit: BoxFit.fill,
        ),),
        tile(context, "videos", Constant.GENRAL_VIDEOS_ARTICLES,Image.asset(
          'assets/images/videos.png',
          fit: BoxFit.fill,
        ),),
      ],
    );
  }

  Widget tile(BuildContext context, String courseName,int materialId, Image image) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if(materialId==Constant.GENRAL_VIDEOS_ARTICLES&&courseName=="articles"){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                ChangeNotifierProvider(
                  create: (context)=>WebViewListViewModel(),
                  child: WebViewList("articles",courseName,materialId,1),
                )
            )
            );

          }
          else if(materialId==Constant.GENRAL_VIDEOS_ARTICLES){
            print('in videos');
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                ChangeNotifierProvider(
                  create: (context)=>VideosViewModel(),
                  child: Videos("videos",courseName,materialId,0),
                )
            )
            );
          }
          else{
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CourseList(courseName,materialId)));
          }

        },
        child: Stack(children: <Widget>[
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
                  width: 80,
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

  Widget speedDial() {
    return SpeedDial(
      marginRight: 32,
      marginBottom: 32,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
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
            onTap: () => print('FIRST CHILD')
        ),
        SpeedDialChild(
          child: Icon(Icons.call),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
        ),
      ],
    );
  }
}
