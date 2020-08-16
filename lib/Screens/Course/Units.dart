import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/QuestionSectionsViewModel.dart';
import 'package:tawjihi/Screens/Course/QuestionsSections.dart';
import 'package:tawjihi/Screens/Course/TestScreen.dart';
import 'package:tawjihi/Screens/Course/TestViewModel.dart';
import 'package:tawjihi/Screens/Course/UnitsViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class Units extends StatefulWidget {

  bool fromTest;
  int materialId;
  Units(this.fromTest,this.materialId);

  @override
  _UnitsState createState() => _UnitsState(fromTest,materialId);
}

class _UnitsState extends State<Units> with BaseScreen {

  bool fromTest;
  int materialId;

  _UnitsState(this.fromTest,this.materialId);
  @override
  Widget build(BuildContext context) {

  getData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            'units',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Consumer<UnitsViewModel>(builder: (context, model, child) {
              return switchWidgets(model, context);
            })
          ],
        )
    );
  }

  Widget viewCard(BuildContext context,int index, UnitsViewModel model,String term) {
    return GestureDetector(
      onTap: () {
           if(fromTest){
             Navigator.of(context)
                 .push(MaterialPageRoute(builder: (_) => ChangeNotifierProvider(
               create: (context)=>TestViewModel(),
               child: TestScreen(materialId,model.units.details[index].id),
             )));
           }
           else{
                     Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) =>
                      ChangeNotifierProvider(
                        create: (context)=>QuestionsSectionsViewModel(),
                        child:QuestionsSections(model.units.details[index].name
                            ,materialId,model.units.details[index].id)),
                      )
                     );

           }



      },
      child: Visibility(
        visible: term==model.units.details[index].term,
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(model.units.details[index].name,
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

  Widget firstTermHeader() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 40,
      decoration: BoxDecoration(color: Color(0x11707070)),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
        child: MyText("first_term",
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey)),
      ),
    );
  }

  Widget secondTermHeader() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 40,
      decoration: BoxDecoration(color: Color(0x11707070)),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
        child: MyText("second_term",
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey)),
      ),
    );
  }

  Widget switchWidgets(UnitsViewModel model, BuildContext context) {
    switch (model.unitsResponseWraper.status) {
      case Status.LOADING:
        return super.loadingIndicator(
            model.unitsResponseWraper.status == Status.LOADING, context);
        break;
      case Status.empty:
        return super
            .loadingIndicator(model.unitsResponseWraper.status == Status.empty, context);

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
        return body(model);
        break;
    }
  }

  Widget body(UnitsViewModel model) {
    return ListView(
      children: <Widget>[
        firstTermHeader(),
        unitsListView(context, model,"1"),
        secondTermHeader(),
        unitsListView(context, model,"2"),
      ],
    );
  }

  Widget unitsListView(BuildContext context,UnitsViewModel model,String term){
    return ListView.builder(
      itemCount: model.units.details.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return viewCard(context,index,model,term);
      },
    );
  }

  void getData() {
    Map<String,dynamic> paramaters=new Map();
    paramaters.putIfAbsent("materialId", () =>materialId);
    Provider.of<UnitsViewModel>(context,listen: false).get(paramaters);
  }
}
