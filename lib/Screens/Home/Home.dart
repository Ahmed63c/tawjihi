import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorProperties.AppColor,
            title: Text(AppLocalizations.of(context).translate("home"),style: TextStyle(color: Colors.white,fontSize: 20
            ,fontWeight: FontWeight.w700,fontFamily: "Cairo"),),
            bottom: tabBar(context),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                },
              )
            ],
          ),
          body: TabBarView(children: <Widget>[
            home(context),
            home(context),
            home(context)
          ],),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: ColorProperties.colorAccent,
            child: Icon(Icons.phone),
          ),
        ),

    );
  }

  Widget home(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 280,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            homeTile(context, "اكتشف", Image.asset('assets/images/m.png', fit: BoxFit.fill,)),
              homeTile(context, "اكتشف", Image.asset('assets/images/m.png', fit: BoxFit.fill,)),


            ],),
        ),
        Row()
      ],
    );
  
  }

  Widget header(BuildContext context) {
  
  }

 Widget  tabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.blueAccent,
      labelColor: Colors.white,
      isScrollable: true,
      labelPadding: EdgeInsets.only(right: 20, left: 20),
      unselectedLabelColor: Colors.grey,
      tabs:[
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
                  fontWeight: FontWeight.w500)
          ),
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


  Widget homeTile(BuildContext context, String footer, Image image) {
    return  GestureDetector(
            child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: image,),
                        Container(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 78,
                                child: Text("الثقافة العامه",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w700
                                  ,fontSize: 18,color: Colors.white),),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 0),
                                    child: Text("اكتشف",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700
                                    ,fontFamily: "Cairo"),)),)


                            ],
                          ),
                        )
                      ]
            ),
    )
      ;
  }
}
