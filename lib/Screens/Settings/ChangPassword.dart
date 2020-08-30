import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Settings/ChangePasswordViewModel.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ChangePassword extends StatefulWidget{
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with BaseScreen {


  bool obSecureText=true;
  IconData iconOn=Icons.visibility;
  IconData iconOff=Icons.visibility_off;
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  bool _validate=false;
  bool _validateConfirm=false;
  ChangePasswordViewModel vm;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    vm=Provider.of<ChangePasswordViewModel>(context);

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
      child: Stack(
        children:[
           Form(
             key: formKey,
             child: ListView(
          children: <Widget>[
              currentPassword(),
              newPassword(),
              confirmNewPassword(),
              errorView(),
              confirmButton(),
          ],
        ),
           ),
           Consumer<ChangePasswordViewModel>(
              builder: (context, model, child){
                WidgetsBinding.instance.addPostFrameCallback((_){
                  if(model.baseResponseWraper.status==Status.COMPLETED){
                    model.baseResponseWraper.status=Status.empty;
                    Navigator.pop(context);
                  }
                });
                return  super.loadingIndicator(model.baseResponseWraper.status==Status.LOADING, context);
              })
          ]
      ),
    );
  }


  Widget currentPassword() {
    return Visibility(
      visible: false,
      child: Padding(
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
      ),
    );
  }

  Widget newPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: true,
        controller: newPasswordController,
          validator:  Validators.compose([
            Validators.required(AppLocalizations.of(context).translate("error_field")),
            Validators.minLength(9, AppLocalizations.of(context).translate("error_pass_validate_less")),
            Validators.maxLength(15, AppLocalizations.of(context).translate("error_pass_validate_more"))
          ]),
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
            suffixIcon: Visibility(
              visible: false,
              child: Icon(
                Icons.visibility_off,
                color: Colors.black,
              ),
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
        controller: confirmPasswordController,
        validator:  Validators.compose([
          Validators.required(AppLocalizations.of(context).translate("error_field")),
          Validators.minLength(9, AppLocalizations.of(context).translate("error_pass_validate_less")),
          Validators.maxLength(15, AppLocalizations.of(context).translate("error_pass_validate_more"))
        ]),
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
            suffixIcon: Visibility(
              visible: false,
              child: Icon(
                Icons.visibility_off,
                color: Colors.black,
              ),
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
            if(formKey.currentState.validate()){
              if(confirmPasswordController.text==newPasswordController.text){
                vm.baseResponseWraper=ApiResponse.empty("");
                vm.error="";

                Map<String,dynamic> paramaters=new Map();
                paramaters.putIfAbsent("new_password", () => newPasswordController.text);
                Provider.of<ChangePasswordViewModel>(context,listen: false).postData(paramaters);
              }
              else{
                print("error");
                vm.baseResponseWraper=ApiResponse.error(AppLocalizations.of(context).translate("error_match"));
                vm.error=AppLocalizations.of(context).translate("error_match");
                vm.notifyListeners();

              }
            }

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

  errorView() {
    return
      Consumer<ChangePasswordViewModel>(
          builder: (context, model, child){
            return Visibility(
              visible: model.baseResponseWraper.status==Status.ERROR,
              child:
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(model.error,
                    style:
                    TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)
              ),
            );
          });

  }



}