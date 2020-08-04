import 'package:flutter/material.dart';
import 'LocalStorage.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    if (StorageUtil.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(StorageUtil.getString('language_code'));
    return Null;
  }


  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await StorageUtil.putString('language_code', 'ar');
      await StorageUtil.putString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await StorageUtil.putString('language_code', 'en');
      await StorageUtil.putString('countryCode', 'US');
    }
    notifyListeners();
  }
}