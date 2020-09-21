import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/Home/MainScreen.dart';
import 'package:tawjihi/Screens/Login/VerfiyScreen.dart';
import 'package:tawjihi/Screens/Login/VerifyScreenViewModel.dart';
import 'package:tawjihi/Screens/SignUp/SignUpFirst.dart';
import 'package:tawjihi/Screens/SignUp/SignUpViewModel.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'LoginViewModel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseScreen {
  bool obSecureText = true;
  IconData iconOn = Icons.visibility;
  IconData iconOff = Icons.visibility_off;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _validate = false;
  bool _validateEmail = false;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //  checkLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[
            loginCard(),
            bottomSignUp(),
            Consumer<LoginViewModel>(builder: (context, model, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (model.user.status == Status.COMPLETED) {
                  model.user.status = Status.empty;
                  if (model.userModel.details.user.status == "active") {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => MainScreen(
                            model.userModel.details.user.major == "scientific"
                                ? false
                                : true)));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                              create: (context) => VerifyScreenViewModel(),
                              child: VerifyScreen(
                                  model.userModel.details.user.major ==
                                          "scientific"
                                      ? false
                                      : true),
                            )));
                  }
                }
              });
              return super.loadingIndicator(
                  model.user.status == Status.LOADING, context);
            })
          ],
        ));
  }

  Widget headerLogo() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/images/tawjihi_logo.png")),
    );
  }

  Widget loginCard() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 80),
        width: MediaQuery.of(context).size.width - 28,
        height: 380,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              cardHeader(),
              emailField(),
              passwordField(),
              errorView(),
              signInButton(),
            ],
          ),
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
        controller: emailController,
        validator: Validators.compose([
          Validators.required(
              AppLocalizations.of(context).translate("error_field")),
        Validators.patternRegExp(
        RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
        r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"),
            AppLocalizations.of(context).translate("error_email_validate")),
        ]),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("hint_email_login"),
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

  Widget passwordField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: obSecureText,
        controller: passController,
        validator: Validators.compose([
          Validators.required(
              AppLocalizations.of(context).translate("error_field")),
          Validators.minLength(
              9,
              AppLocalizations.of(context)
                  .translate("error_pass_validate_less")),
          Validators.maxLength(
              15,
              AppLocalizations.of(context)
                  .translate("error_pass_validate_more"))
        ]),
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
            suffixIcon:
            IconButton(
              icon: Icon(obSecureText ? iconOff : iconOn),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  obSecureText = obSecureText ? false : true;
                });
              },
            )
        ),
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
            if (formKey.currentState.validate()) {
              Map<String, dynamic> paramaters = new Map();
              paramaters.putIfAbsent("email", () => emailController.text);
              paramaters.putIfAbsent("password", () => passController.text);
              Provider.of<LoginViewModel>(context, listen: false)
                  .postData(paramaters);
            }

            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                        create: (context) => SignUpViewModel(),
                        child: SignUpFirst())));
              //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MainScreen(false)));

              },
            )
          ],
        ));
  }

  errorView() {
    return Consumer<LoginViewModel>(builder: (context, model, child) {
      return Visibility(
        visible: model.user.status == Status.ERROR,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              model.error,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                  color: Colors.red),
            )),
      );
    });
  }
}
