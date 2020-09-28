import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends ChangeNotifier{
  int _loginValue=0;
  int get loginValue => _loginValue;
  SharedPreferences pref;

  set loginValue(int val){
    _loginValue=val;
    notifyListeners();
  }

  increment(int i){
    print("Incremented Value: "+_loginValue.toString());
    loginValue=i;
  }

  decrement(int i){
    loginValue=i;
  }
}