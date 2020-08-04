import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/SignUpScreens/SignUpFirst.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[headerLogo(), loginCard(), bottomSignUp()],
        ));
  }

  Widget headerLogo() {
    return Center();
  }

  Widget loginCard() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 64),
        width: MediaQuery.of(context).size.width - 28,
        height: 356,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: ListView(
          children: <Widget>[
            cardHeader(),
            emailField(),
            passwordField(),
            signInButton()
          ],
        ),
      ),
    );
  }

  Widget cardHeader() {
    return Center(
      child: MyText(
        "login",
        style: TextStyle(
            color: ColorProperties.colorAccent,
            fontWeight: FontWeight.w700,
            fontFamily: "Cairo",
            fontSize: 20),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 30),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("hint_email_login"),
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
        ),
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

  Widget signInButton() {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 40),
        child: RaisedButton(
          color: ColorProperties.AppColorHex,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "sign_in",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700),
          ),
        ));
  }

  Widget bottomSignUp() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 1, right: 1, bottom: 16),
              child: MyText(
                "dont_have_account",
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
                  "register_new_user",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                ),
              ),
              onTap: (){            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUpFirst()));
              },
            )
          ],
        ));
  }
}
