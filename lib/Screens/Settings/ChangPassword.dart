import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class ChangePassword extends StatefulWidget{
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            "change_password",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body(context)
    );
  }

  Widget body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          currentPassword(),
          newPassword(),
          confirmNewPassword(),
          confirmButton()
        ],
      ),
    );
  }


  Widget currentPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: InputDecoration(
            labelText:
            AppLocalizations.of(context).translate("current_password"),
            labelStyle: TextStyle(color: Colors.grey,fontFamily: "Cairo"),
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
            )),
      ),
    );
  }

  Widget newPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: InputDecoration(
            labelText:
            AppLocalizations.of(context).translate("new_password"),
            labelStyle: TextStyle(color: Colors.grey,fontFamily: "Cairo"),
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
            )),
      ),
    );
  }

  Widget confirmNewPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: InputDecoration(
            labelText:
            AppLocalizations.of(context).translate("confirm_password"),
            labelStyle: TextStyle(color: Colors.grey,fontFamily: "Cairo"),
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
            )),
      ),
    );
  }

  Widget confirmButton() {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 100),
        child: RaisedButton(
          color: ColorProperties.AppColorHex,
          textColor: Colors.white,
          onPressed: () {
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "update",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700),
          ),
        ));
  }



}