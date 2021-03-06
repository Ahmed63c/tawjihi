import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/SignUp/SignUpViewModel.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'SignUpSecond.dart';

class SignUpFirst extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpFirst> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController parentPhoneController = TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[
            signUpFirstCard(),
          ],
        ));
  }

  Widget signUpFirstCard() {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 80,bottom: 24),
        width: MediaQuery.of(context).size.width - 32,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child:
       ListView(
         children: [
           Padding(
             padding: EdgeInsets.only(bottom: bottom),
             child: Form(
         key: formKey,
         child: Column(
             children: <Widget>[
               cardHeader(),
               emailField(),
               fullNameField(),
               regionNameField(),
               schoolNameField(),
               phoneField(),
               parentPhoneField(),
               nextButton()
             ],
         ),
       ),
           )],),
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

  Widget emailField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 28),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
          validator: Validators.compose([
            Validators.required(AppLocalizations.of(context).translate("error_field")),
            Validators.patternRegExp(
                RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
                r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"),
                AppLocalizations.of(context).translate("error_email_validate")),
          ]),
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

  Widget fullNameField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: nameController,
        validator:
        Validators.compose([
          Validators.required(AppLocalizations.of(context).translate("error_field")),
          // Validators.patternRegExp(
          //     RegExp(r"^[\u0621-\u064A0-9 ]+$"), AppLocalizations.of(context).translate("error_alphapet")),
          Validators.minLength(
              3,
              AppLocalizations.of(context)
                  .translate("error_less_character")),
        ]),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("full_name"),
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

  Widget regionNameField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: regionController,
        validator:  Validators.compose([
          Validators.required(AppLocalizations.of(context).translate("error_field")),
          // Validators.patternRegExp(
          //     RegExp(r"^[\u0621-\u064A0-9 ]+$"), AppLocalizations.of(context).translate("error_alphapet")),
          Validators.minLength(
              3,
              AppLocalizations.of(context)
                  .translate("error_less_character")),
        ]),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("region_name"),
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

  Widget schoolNameField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: schoolController,
        validator:   Validators.compose([
          Validators.required(AppLocalizations.of(context).translate("error_field")),
          // Validators.patternRegExp(
          //     RegExp(r"^[\u0621-\u064A0-9 ]+$"), AppLocalizations.of(context).translate("error_alphapet")),
          Validators.minLength(
              3,
              AppLocalizations.of(context)
                  .translate("error_less_character")),
        ]),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("school_name"),
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

  Widget phoneField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: phoneController,
        validator: Validators.compose([
          Validators.required(AppLocalizations.of(context).translate("error_field")),
          Validators.minLength(
              10,
              AppLocalizations.of(context)
                  .translate("error_phone_less")),
//           Validators.patternRegExp(
//              RegExp(r"^(?:[+0]9)?[0-9]{10}$"), AppLocalizations.of(context).translate("error_phone_validate")),
        ]),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("phone"),
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

  Widget parentPhoneField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: parentPhoneController,
        validator: Validators.compose([
          Validators.required(AppLocalizations.of(context).translate("error_field")),
          Validators.minLength(
              10,
              AppLocalizations.of(context)
                  .translate("error_phone_less")),

//          Validators.patternRegExp(
//              RegExp(r"^(?:[+0]10)?[0-9]{11}$"), AppLocalizations.of(context).translate("error_phone_validate")),
        ]),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("parent_phone"),
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

  Widget nextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
      Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child:

          RaisedButton(
            color: ColorProperties.AppColorHex,
            textColor: Colors.white,
            onPressed: () {
              if (formKey.currentState.validate()) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                    ChangeNotifierProvider(
                    create: (context)=>SignUpViewModel(),
                    child: SignUpSecond(emailController.text,nameController.text,
                    regionController.text,schoolController.text,phoneController.text,
                    parentPhoneController.text)
                )
                )
                );
                }

              },

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  MyText(
                    "next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8,right: 8),
                      child: Icon(Icons.arrow_forward_ios,size: 14,))
                ],)
          ))
    ]);
  }
}
