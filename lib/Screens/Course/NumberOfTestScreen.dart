import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/NumberOfTestsViewModel.dart';
import 'package:tawjihi/Screens/Course/QuestionSectionsViewModel.dart';
import 'package:tawjihi/Screens/Course/QuestionsSections.dart';
import 'package:tawjihi/Screens/Course/TestScreen.dart';
import 'package:tawjihi/Screens/Course/TestViewModel.dart';
import 'package:tawjihi/Screens/Course/UnitsViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class NumberOfTestsScreen extends StatefulWidget {

  bool fromTest;
  int materialId;
  int unitId;
  int SectionId;
  NumberOfTestsScreen(this.materialId,this.unitId);

  @override
  _NumberOfTestsScreen createState() => _NumberOfTestsScreen(materialId,unitId);
}

class _NumberOfTestsScreen extends State<NumberOfTestsScreen> with BaseScreen {

  bool fromTest;
  int materialId;
  int unitId;
  int testNumber=1;

  _NumberOfTestsScreen(this.materialId,this.unitId);
  @override
  Widget build(BuildContext context) {

    getData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            'Tests',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Consumer<NumberOfTestsViewModel>(builder: (context, model, child) {
              return switchWidgets(model, context);
            })
          ],
        )
    );
  }

  Widget viewCard(BuildContext context,int index, NumberOfTestsViewModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ChangeNotifierProvider(
          create: (context)=>TestViewModel(),
          child: TestScreen(materialId,unitId,index+1),
        )));
      },
      child: Directionality(
          textDirection:materialId==2?TextDirection.ltr:TextDirection.rtl,
          child: Card(
            elevation: 4,
            child: ListTile(
              title: Text(" اختبار رقم ${index+1}",
                style: TextStyle(
                    fontFamily: "Cairo", fontSize: 18, fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget switchWidgets(NumberOfTestsViewModel model, BuildContext context) {
    switch (model.wrapper.status) {
      case Status.LOADING:
        return super.loadingIndicator(
            model.wrapper.status == Status.LOADING, context);
        break;
      case Status.empty:
        return super
            .loadingIndicator(model.wrapper.status == Status.empty, context);

      case Status.ERROR:
        return Visibility(
          visible: model.wrapper.status == Status.ERROR,
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
        break;
      case Status.COMPLETED:
        return body(model);
        break;
    }
  }

  Widget body(NumberOfTestsViewModel model) {
    return ListView(
      children: <Widget>[
        TestListView(context, model),
      ],
    );
  }

  Widget TestListView(BuildContext context,NumberOfTestsViewModel model){
    return ListView.builder(
      itemCount: model.model.details,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return viewCard(context,index,model);
      },
    );
  }

  void getData() {
    Map<String,dynamic> paramaters=new Map();
    paramaters.putIfAbsent("materialId", () =>materialId);
    paramaters.putIfAbsent("unitId", () =>unitId);
    Provider.of<NumberOfTestsViewModel>(context,listen: false).get(paramaters);
  }
}
