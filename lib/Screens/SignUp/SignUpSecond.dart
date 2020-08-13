import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/Login/LoginView.dart';
import 'package:tawjihi/Screens/Login/LoginViewModel.dart';
import 'package:tawjihi/Screens/SignUp/SignUpViewModel.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

import 'SignUpFirst.dart';

class SignUpSecond extends StatefulWidget {
  String email = "";
  String name = "";
  String area = "";
  String school = "";
  String phone = "";
  String parentPhone = "";

  SignUpSecond(this.email, this.name, this.area, this.school, this.phone,
      this.parentPhone);

  @override
  _SignUpSecond createState() =>
      _SignUpSecond(email, name, area, school, phone, parentPhone);
}

class _SignUpSecond extends State<SignUpSecond> with BaseScreen{
  String email = "";
  String name = "";
  String area = "";
  String school = "";
  String phone = "";
  String parentPhone = "";

  bool isLiterary = true;
  bool obSecureText = true;
  bool _validate = false;

  IconData iconOn = Icons.visibility;
  IconData iconOff = Icons.visibility_off;
  TextEditingController confirmController = TextEditingController();
  TextEditingController passController = TextEditingController();

  _SignUpSecond(this.email, this.name, this.area, this.school, this.phone,
      this.parentPhone);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[signUpSecondCard(), bottomLogin(),
            Consumer<SignUpViewModel>(
                builder: (context, model, child){
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    if(model.user.status==Status.COMPLETED){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            Home(isLiterary)),
                      );
                    }
                  });
                  return  super.loadingIndicator(model.user.status==Status.LOADING, context);
                })
          ],
        ));
  }

  Widget signUpSecondCard() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 64),
        width: MediaQuery.of(context).size.width - 28,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: ListView(
          children: <Widget>[
            cardHeader(),
            passwordField(),
            passwordConfirmField(),
            chooseCategoryRow(),
            errorView(),
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
            color: ColorProperties.colorAccent,
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
        obscureText: obSecureText,
        controller: passController,
        decoration: InputDecoration(
            errorText: _validate
                ? AppLocalizations.of(context).translate("error_field")
                : null,
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
            suffixIcon: IconButton(
              icon: Icon(obSecureText ? iconOff : iconOn),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  obSecureText = obSecureText ? false : true;
                });
              },
            )),
      ),
    );
  }

  Widget passwordConfirmField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: obSecureText,
        controller: confirmController,
        decoration: InputDecoration(
          errorText: _validate
              ? AppLocalizations.of(context).translate("error_field")
              : null,
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
                color: isLiterary
                    ? ColorProperties.colorAccent
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8)),
            child: MyText(
              "literary",
              style: TextStyle(
                  color:
                      isLiterary ? Colors.white : ColorProperties.colorAccent,
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
                onTap: () {
                  setState(() {
                    isLiterary = isLiterary == true ? false : true;
                  });
                }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: isLiterary
                    ? Colors.transparent
                    : ColorProperties.colorAccent,
                borderRadius: BorderRadius.circular(8)),
            child: MyText(
              "scientific",
              style: TextStyle(
                  color:
                      isLiterary ? ColorProperties.colorAccent : Colors.white,
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
      children: <Widget>[previousButton(), subscripeButton()],
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                          create: (context) => LoginViewModel(),
                          child: LoginView(),
                        )));
              },
            )
          ],
        ));
  }

  Widget previousButton() {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: FlatButton(
            color: Colors.transparent,
            textColor: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    child: Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                )),
                MyText(
                  "previous",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700),
                ),
              ],
            )));
  }

  Widget subscripeButton() {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: RaisedButton(
          color: ColorProperties.AppColorHex,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              confirmController.text.isEmpty
                  ? _validate = true
                  : _validate = false;
              passController.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });
            if (!_validate) {
              FormData formData = FormData.fromMap({
                "email": email,
                "name": name,
                "area": area,
                "school": school,
                "contact_number": phone,
                "parent_contact_number": parentPhone,
                "password":passController.text,
                "password_confirmation":confirmController.text,
                "major":isLiterary?"literature":"scientific"
              });
              Provider.of<SignUpViewModel>(context,listen: false).postData(formData);
            }
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
        ));
  }

  errorView() {
    return
      Consumer<SignUpViewModel>(
          builder: (context, model, child){
            return    Visibility(
              visible: model.user.status==Status.ERROR,
              child:Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(model.error,
                    style:
                    TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
            );
          });

  }

}
