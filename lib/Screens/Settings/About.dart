import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class About extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            "about",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body(context)
    );
  }

  Widget body(BuildContext context) {
    return ListView(
      children: [
        aboutText()

      ],
    );

  }


  Widget aboutText() {
    String test="تطبيق توجيهي الفلسطيني الجديد آفاق بلا حدود معنا تصبح الثورة الرقمية في خدمة طلاب التوجيهي  من خلال تطبيق ذكي يتسم بالشمولية والدقة العلمية وسهولة الاستخداميهدف لخدمة الطلاب و تسهيل الدراسة و تحويلها لمتعة و إفادة في نفس الوقتحيث يغطي كافة متطلبات التوجيهي في الفرعين الأدبي والعلمي  بطرق منهجية و واضحة و بأسلوب شيق يناسب كافة الطلاب بمستوياتهم المختلفة يغطي التطبيق كافة المواد الأساسية كالرياضيات والأحياء والكيمياء والفيزياء في الفرع العلمي، والتاريخ والجغرافيا والثقافة العلمية في الفرع الأدبي.و المواد المشتركة كاللغة العربية واللغة الانجليزيةيحتوي التطبيق على مقالات امتحانات مدرسية , أوراق عمل , امتحانات سنوات سابقة , أسئلة ومواضيع مهمة , اختبارات عملية وغيرها.حيث ينقسم التطبيق إلى اختبار ضع دائرة حيث يغطي جميع الأسئلة الممكنة التي تخص المادة ومقسمة لوحدات وأيضاً فقرة عبارة عن سؤال وجواب وهو تلخيص المنهاج بطريقة عرض ( سؤال وجواب)بالإضافة الى زاوية الارشاد التربوي والأكاديمي التي تتضمن  تنظيم الدراسة , قلق الامتحانات , مهارات التفوق , مشكلات وحلول , كيف تختار التخصص المناسب؟ ,منح جامعية , الجامعات الفلسطينية والعربية والدولية مع خط اتصال مباشر ومجاني بين المستخدمين وإدارة التطبيق من خبراء ومعلمين ومشرفين مع ضمان الشفافية بالإجابة و التفاعل كل ذلك وأكثر في تطبيق توجيهي الفلسطيني الجديد معاً ننطلق في آفاق بلا حدود لتحقيق النجاح و التفوق ";

    return
      Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
      child: Text(test,
        style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500,
            fontSize: 16,color: Colors.black),),
    );
  }


}