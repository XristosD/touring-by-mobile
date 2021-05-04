import 'package:flutter/material.dart';

enum ViewState {Idle, Busy}

class TouringByModel extends ChangeNotifier {
  ViewState _state;
  String testText;

  ViewState get state => _state;

  Future initialLoad() async {
    testText = "test text";
    await new Future.delayed(const Duration(seconds: 4));
    return true;
  }

  Future nextTouringByPoint() async {
    testText = "test text";
    await new Future.delayed(const Duration(seconds: 4));
    return true;
  }

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }

}