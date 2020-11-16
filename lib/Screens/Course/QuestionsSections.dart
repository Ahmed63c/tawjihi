import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/NumberOfQAScreen.dart';
import 'package:tawjihi/Screens/Course/NumberOfQAViewModel.dart';
import 'package:tawjihi/Screens/Course/QuestionAndAnswersScreen.dart';
import 'package:tawjihi/Screens/Course/QuestionSectionsViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

import 'QuestionsAndAnswersViewModel.dart';

class QuestionsSections extends StatefulWidget {
  String appBarHeader = "";
  int materialId;
  int unitId;

  QuestionsSections(this.appBarHeader, this.materialId, this.unitId);

  @override
  _QuestionsSectionsState createState() =>
      _QuestionsSectionsState(materialId, unitId);
}

class _QuestionsSectionsState extends State<QuestionsSections> with BaseScreen {
  int materialId;
  int unitId;

  _QuestionsSectionsState(this.materialId, this.unitId);

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: Text(
            '${widget.appBarHeader}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Consumer<QuestionsSectionsViewModel>(
                builder: (context, model, child) {
              return switchWidgets(model, context);
            })
          ],
        )
    );
  }

  Widget viewCard(
      BuildContext context, int index, QuestionsSectionsViewModel model) {
    return GestureDetector(
      onTap: () {
        String title = model.units.details[index].name;
        int sectionId = model.units.details[index].id;
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (_) => ChangeNotifierProvider(
        //       create: (context) => QuestionsAndAnswersViewModel(),
        //       child: QAndAnswers(title, materialId, unitId, sectionId)),
        // ));

        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (context) => NumberOFQAViewModel(),
              child: NumberOfQAScreen(title, materialId, unitId, sectionId)),
        ));



      },
      child: Directionality(
        textDirection:materialId==2?TextDirection.ltr:TextDirection.rtl,
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              model.units.details[index].name != null
                  ? model.units.details[index].name
                  : "",
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

  void getData() {
    Map<String, dynamic> paramaters = new Map();
    paramaters.putIfAbsent("materialId", () => materialId);
    Provider.of<QuestionsSectionsViewModel>(context, listen: false)
        .get(paramaters);
  }

  Widget switchWidgets(QuestionsSectionsViewModel model, BuildContext context) {
    switch (model.unitsResponseWraper.status) {
      case Status.LOADING:
        return super.loadingIndicator(
            model.unitsResponseWraper.status == Status.LOADING, context);
        break;
      case Status.empty:
        return super.loadingIndicator(
            model.unitsResponseWraper.status == Status.empty, context);

      case Status.ERROR:
        return Visibility(
          visible: model.unitsResponseWraper.status == Status.ERROR,
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
        return model.units.details.length > 0
            ? body(model)
            : Container(
                child: Center(
                  child: MyText(
                    "error_empty",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              );
        break;
    }
  }

  Widget body(QuestionsSectionsViewModel model) {
    return ListView.builder(
      itemCount: model.units.details.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return viewCard(context, index, model);
      },
    );
  }
}
