import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/LoginScreen/LoginView.dart';
import 'package:tawjihi/Screens/SignUpScreens/SignUpFirst.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class SignUpSecond extends StatefulWidget {
  @override
  _SignUpSecond createState() => _SignUpSecond();
}

class _SignUpSecond extends State<SignUpSecond> {

  bool isLiterary=true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[signUpSecondCard(), bottomLogin()],
        ));
  }

  Widget signUpSecondCard() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 64),
        width: MediaQuery.of(context).size.width - 28,
        height: 380,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: ListView(
          children: <Widget>[
            cardHeader(),
            passwordField(),
            passwordConfirmField(),
            chooseCategoryRow(),
            actionRow()
          ],
        ),
      ),
    );
  }

  Widget cardHeader() {
    return Center(
      child: MyText(
        "register_new_user",
        style: TextStyle(
            color:  ColorProperties.colorAccent,
            fontWeight: FontWeight.w700,
            fontFamily: "Cairo",
            fontSize: 20),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText:
                AppLocalizations.of(context).translate("hint_password_login"),
            labelStyle: TextStyle(color: Colors.grey, fontFamily: "Cairo"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ColorProperties.AppColor, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            suffixIcon: Icon(
              Icons.visibility_off,
              color: Colors.black,
            )
        ),
      ),
    );
  }

  Widget passwordConfirmField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText:
                AppLocalizations.of(context).translate("hint_password_confirm"),
            labelStyle: TextStyle(color: Colors.grey, fontFamily: "Cairo"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ColorProperties.AppColor, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),

        ),
      ),
    );
  }

  chooseCategoryRow() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color:isLiterary?ColorProperties.colorAccent:Colors.transparent, borderRadius: BorderRadius.circular(8)),
            child: MyText(
              "literary",
              style: TextStyle(
                  color:isLiterary?Colors.white:ColorProperties.colorAccent,
                  fontSize: 18,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: InkWell(
                child: Icon(Icons.swap_horiz),
            onTap: (){
                  setState(() {
                    isLiterary= isLiterary==true? false : true;
                  });
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: isLiterary?Colors.transparent:ColorProperties.colorAccent, borderRadius: BorderRadius.circular(8)),
            child: MyText(
              "scientific",
              style: TextStyle(
                  color: isLiterary?ColorProperties.colorAccent:Colors.white,
                  fontSize: 18,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: FlatButton(
                color: Colors.transparent,
                textColor: Colors.grey,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        child: Icon(Icons.arrow_back_ios,size: 14,)),
                    MyText(
                      "previous",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700),
                    ),
                  ],)
            )),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: RaisedButton(
              color: ColorProperties.AppColorHex,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SignUpFirst()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: MyText(
                "Subscribe",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w700),
              ),
            ))

      ],
    );
  }

  Widget bottomLogin() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 1, right: 1, bottom: 16),
              child: MyText(
                "already_have_acount",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w500),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 1, right: 1, bottom: 16),
                child: MyText(
                  "login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginView()));
              },
            )
          ],
        ));
  }
}
