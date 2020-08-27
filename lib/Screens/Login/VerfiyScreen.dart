import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

// ignore: must_be_immutable
class VerifyScreen extends StatefulWidget{
  bool isLiteral;
  VerifyScreen(this.isLiteral);
  @override
  _VerifyScreenState createState() => _VerifyScreenState(isLiteral);
}

class _VerifyScreenState extends State<VerifyScreen> {

  TextEditingController _editingController;
  bool _validate=false;
  bool isLiteral;
  _VerifyScreenState(this.isLiteral);

  @override
  void initState() {
    super.initState();
    _editingController=new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[
            verifyCard(),
          ],
        )
    );
  }

  Widget headerLogo() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/images/tawjihi_logo.png")),
    )
    ;
  }

  Widget verifyCard() {
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
            codeField(),
            verifyButton(),
          ],
        ),
      ),
    );
  }

  Widget cardHeader() {
    return Center(
      child: MyText(
        "verify",
        style: TextStyle(
            color: ColorProperties.colorAccent,
            fontWeight: FontWeight.w700,
            fontFamily: "Cairo",
            fontSize: 20),
      ),
    );
  }

  Widget codeField() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _editingController,
        decoration: InputDecoration(
          errorText: _validate ? AppLocalizations.of(context).translate("error_field") : null,
          labelText: AppLocalizations.of(context).translate("verify_code"),
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

  Widget verifyButton() {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 40),
        child: RaisedButton(
          color: ColorProperties.AppColorHex,
          textColor: Colors.white,
          onPressed: (){
            print("pressed");
            setState(() {
              _editingController.text.isEmpty ? _validate = true : _validate = false;
            });

            if(!_validate){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>
                    Home(isLiteral)),
              );

            }
            },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "verify_button",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700),
          ),
        ));
  }

}

