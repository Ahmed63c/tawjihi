import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/Home/MainScreen.dart';
import 'package:tawjihi/Screens/Login/ForgetPasswordViewModel.dart';
import 'package:tawjihi/Screens/Login/LoginView.dart';
import 'package:tawjihi/Screens/Login/LoginViewModel.dart';
import 'package:tawjihi/Screens/Login/VerifyScreenViewModel.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

// ignore: must_be_immutable
class ForgetPasswordView extends StatefulWidget {
  @override
  _ForgetPasswordView createState() => _ForgetPasswordView();
}

class _ForgetPasswordView extends State<ForgetPasswordView> with BaseScreen {
  TextEditingController emailController;
  bool _validate = false;
  bool isLiteral;
  String helpText="";

  _ForgetPasswordView();

  @override
  void initState() {
    super.initState();
    emailController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[
            forgetPasswordCard(),
            Consumer<ForgetPasswordViewModel>(builder: (context, model, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (model.resposeWrapper.status == Status.COMPLETED) {
                  model.resposeWrapper.status = Status.empty;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>ChangeNotifierProvider(
                        create: (context)=>LoginViewModel(),
                        child: LoginView(),))
                  );
                }
              });
              return super.loadingIndicator(
                  model.resposeWrapper.status == Status.LOADING, context);
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

  Widget forgetPasswordCard() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 80),
        width: MediaQuery.of(context).size.width - 28,
        height: 380,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            cardHeader(),
            cardHeadereXplain(),
            emailField(),
            errorView(),
            confirmButton(),

          ],
        ),
      ),
    );
  }

  Widget cardHeader() {
    return Center(
      child: MyText(
        "Forgotten_password",
        style: TextStyle(
            color: ColorProperties.colorAccent,
            fontWeight: FontWeight.w700,
            fontFamily: "Cairo",
            fontSize: 20),
      ),
    );
  }

  Widget cardHeadereXplain() {
    return Center(
      child: MyText(
        "Forgotten_password_details",
        style: TextStyle(
            color: ColorProperties.colorAccent,
            fontWeight: FontWeight.w500,
            fontFamily: "Cairo",
            fontSize: 14),
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

  Widget confirmButton() {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 40),
        child: MaterialButton(
          color: ColorProperties.AppColorHex,
          textColor: Colors.white,
          onPressed: () {
            print("pressed");
            setState(() {
              emailController.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });

            if (!_validate) {
              Map<String, dynamic> paramaters = new Map();
              paramaters.putIfAbsent("email", () => emailController.text);
              Provider.of<ForgetPasswordViewModel>(context, listen: false)
                  .postData(paramaters);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "confirm",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700),
          ),
        ));
  }

  errorView() {
    return Consumer<ForgetPasswordViewModel>(builder: (context, model, child) {
      return Visibility(
        visible: model.resposeWrapper.status == Status.ERROR,
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
