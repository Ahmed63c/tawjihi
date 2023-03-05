import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';

class MyText extends StatelessWidget {
  String data;
  InlineSpan textSpan;
  TextStyle style;
  StrutStyle strutStyle;
  TextAlign textAlign;
  TextDirection textDirection;
  Locale locale;
  bool softWrap;
  TextOverflow overflow;
  double textScaleFactor;
  int maxLines;
  String semanticsLabel;
  TextWidthBasis textWidthBasis;

  MyText(
      this.data, {
        Key key,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
        this.textWidthBasis,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).translate(data),
      style: style,
      semanticsLabel: semanticsLabel,
      locale: locale,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}